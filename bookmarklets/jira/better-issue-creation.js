async function betterTicketCreation() {
  let projectCache = new Map();
  let origin = location.origin;

  /**
   * These could break later
   */
  let jiraClasses = {
    input: 'css-ab3pym eq4kchp7',
    button: 'css-1g6jj8c',
  };

  /**
   * NOTE: this only works if you're on a project board
   */
  let jira = {
    qps: {
      pid: await getProjectId(),
      issuetype: await getIssueTypeId('Technical Story'),
      description: 'some description',
      reporter: getCurrentUserId(),
      assignee: getCurrentUserId(),
      /**
       * NOTE: custom field ids are easily found in the Jira UI
       *       via inspect element.
       */
      // Sprint
      'customfield_10010': await getActiveSprint(),
      // PED Work Category \
      // - 14336: KTLO
      // - 14335: Technical Improvement
      'customfield_13507': '14335',
      // 2025 PED Goal
      // - 13424: Prioritized non-Goal work
      'customfield_12761': '13424',
      // Estimated Story Points
      // - 2 is as good as any other number
      'customfield_10014': '2',
    },
  }

  let variants = [
    // Values found via the create ticket UI in the browser 
    // (and graphql?q=TeamSearchV2 in the network panel on a user profile page)
    {
      label: 'Efficiency', qps: {
        'customfield_10001': '991fca23-e03a-462e-a74a-db4386d9b6cc'
      }
    },
    {
      label: 'API Contracts', qps: {
        'customfield_10001': '71402fdc-2799-44a3-8f6a-46fe9cc7472d'
      }
    },
    {
      label: 'Web Frameworks', qps: {
        'customfield_10001': 'a72f2917-9068-4ada-889b-6c79609b7c51'
      }
    },
  ];




  function assert(message, test) {
    if (!test) { throw new Error(message); }
  }

  async function getProjectId() {
    let projectInfo = await getProjectInfo();
    return projectInfo.id;
  }

  async function getIssueTypeId(name) {
    let projectInfo = await getProjectInfo();

    for (let issueType of projectInfo.issueTypes) {
      if (issueType.name === name) {
        return issueType.id;
      }
    }

    assert(`Could not find issue type: ${name}`);
  }

  async function getProjectInfo() {
    let currentProject = getProjectKeyFromPage();

    if (projectCache.has(currentProject)) {
      return projectCache.get(currentProject);
    }
    let response = await fetch(`${origin}/rest/api/latest/project/${currentProject}`, {
      method: 'GET',
    });
    let json = await response.json();

    projectCache.set(currentProject, json);
    return json;
  }

  function getProjectKeyFromPage() {
    let url = location.href;

    assert(`URL mest have /projects/`, url.includes('/projects/'));

    return url.split('/projects/')[1].split(/\?|\//)[0];
  }

  function getBoardIDFromPage() {
    let url = location.href;

    assert(`URL mest have /boards`, url.includes('/boards'));

    return url.split('/boards/')[1].split(/\?|\//)[0];
  }

  async function getActiveSprint() {
    let boardId = getBoardIDFromPage();
    let response = await fetch(`${origin}/rest/agile/1.0/board/${boardId}/sprint?state=active`, {
      method: 'GET',
    });
    let json = await response.json();

    let id = json.values?.[0]?.id;

    assert(`There is no active sprint for response: JSON.stringify(json)`, id);

    return id;
  }

  function getCurrentUserId() {
    let avatarElement = document.querySelector('img[src*=avatar]');

    assert(`Could not find avatar element. Parsing the 'src' is how we get the current User ID`, avatarElement);
    let src = avatarElement.getAttribute('src')
    let url = new URL(src);
    let pathParts = url.pathname.split('/').filter(Boolean)

    let id = pathParts[0];

    assert(`Could not find user ID from avatar img:src:${src}`, id);

    return id;
  }

  async function insertUI() {
    /**
     * NOTE: we can't clear this element, because Jira appears to have an infinite useEffect loop
     *       that regularly tries to update everything (relative timestamps everywhere? idk). 
     *       This is evident by react-scan / render-scan highlighting everything occasionally.
     */
    let parent = document.querySelector('header');
    [...parent.children].forEach(child => child.style = "display:none;");

    let container = document.createElement('div');
    parent.appendChild(container);
    container.classList.add('pico');
    Object.assign(container.style, {
      display: 'flex',
    });
    let layout = document.createElement('div');
    layout.classList.add('grid');
    layout.innerHTML = `<p style="color: white;">&nbsp;&nbsp; ❯ &nbsp;&nbsp;Create Ticket&nbsp;&nbsp; ❯</p>`;
    Object.assign(layout.style, {
      display: 'grid',
      alignItems: 'center',
      gridTemplateColumns: 'unset',
      gridAutoFlow: 'column',
      gap: '1rem',
    });
    container.appendChild(layout);

    /**
     * oooof: https://github.com/picocss/pico/issues/606
     *        https://github.com/picocss/pico/issues/533
     */
    // let css = document.createElement('link');
    // Object.assign(css, { rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/@picocss/pico@2.1.1/css/pico.conditional.min.css' });
    // container.appendChild(css);
    let styles = document.createElement('style');
    styles.innerHTML = `
      :root {
        --pico-line-height: 1;
        --pico-border-radius: 0.25rem;
        --pico-form-element-spacing-vertical: 0.125rem;
        --pico-nav-link-spacing-vertical: 0.25rem;
        --pico-nav-link-spacing-horizontal: 0.5rem;


        /* no margins, please */
        --pico-spacing: 0;
        --pico-typography-spacing-vertical: 0;
        --pico-nav-element-spacing-vertical: 0;
        --pico-nav-element-spacing-horizontal: 0;
      }


      .sr-only {
        position: absolute;
        width: 1px;
        height: 1px;
        padding: 0;
        margin: -1px;
        overflow: hidden;
        clip: rect(0, 0, 0, 0);
        white-space: nowrap;
        border-width: 0;
      }
    `;

    container.appendChild(styles);

    let summaryLabel = document.createElement('label');
    summaryLabel.innerHTML = `
      <span class="sr-only">Summary</span>
      <input id="better-jira-summary" placeholder="Summary" class="${jiraClasses.input}">
    `;
    layout.appendChild(summaryLabel);
    Object.assign(document.querySelector('#better-jira-summary').style, {
      margin: 0,
    });

    function createLink(text, url, { qps }) {
      let anchor = document.createElement('a');
      anchor.href = `${url}?${new URLSearchParams(qps).toString()}`;
      anchor.innerHTML = text;
      anchor.target = '_blank';
      anchor.classList.add(jiraClasses.button);
      return anchor;
    }

    for (let variant of variants) {
      let a = createLink(`${variant.label}`, `${origin}/secure/CreateIssueDetails!init.jspa`, {
        qps: {
          ...jira.qps,
          ...variant.qps,
        },
      });

      a.addEventListener('click', (e) => {
        e.preventDefault();

        let summary = document.getElementById('better-jira-summary').value;
        if (summary) {
          a.href += `&summary=${encodeURIComponent(summary)}`;
        }

        window.open(a.href, '_blank');
      })
      layout.appendChild(a);
    }
  }

  await insertUI();
}

betterTicketCreation();
