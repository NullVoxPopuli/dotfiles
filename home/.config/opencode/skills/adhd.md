---
name: adhd-friendly-writing
description: Write and revise PR descriptions, code review comments, commit messages, issue replies, release notes, and chat messages so a distracted reader gets the whole point from the first line. Front-loads the takeaway, cuts length hard, and strips AI writing tells at both the phrase level (em dashes, "Great question!", "here's the thing," rule-of-three, "not just X, but Y," emoji, sentence-length bold) and the rhythm level (fake punchy fragments, metronomic sentence lengths, structural symmetry). Use this whenever drafting or editing text another human will read: a PR body, review feedback, a standup update, an issue reply, a Slack or Discord message, even when the user hasn't asked for a specific style. Also use it when the user says something reads too long, too formal, or too much like AI wrote it.
---

 
# Writing for readers who will bail
 
## The reader model
 
Assume the reader is mid-context-switch. They opened your PR between two other things, they have four tabs of their own work still loaded in their head, and they will decide within about two seconds whether to keep reading. Many of them have ADHD. All of them are skimming.
 
That means the cost of a wasted first line is not "slightly slower reading." It's the reader closing the tab and your message going unread, or worse, half-read and misunderstood.
 
Everything below follows from that one fact.
 
## Put the payload first
 
The first line has to survive alone. If someone reads only that line and nothing else, they should know what happened and what it means for them.
 
Bad first lines: setup, context, what you were trying to do, what the ticket said.
Good first lines: what changed, what broke, what you need from them.
 
For anything longer than a short paragraph, structure it as takeaway then detail:
 
```
<one line: what this does and why anyone should care>
 
<the details, for whoever needs them>
```
 
In a PR description or a doc, an explicit `tl;dr` label is fine and welcome. In a chat message or a review comment, don't label it, just lead with it. A one-line message doesn't need a tl;dr of itself.
 
## Cut it down
 
Rough ceilings, not laws:
 
- Review comment: one to three sentences. If it's longer, you're probably explaining something that belongs in a doc or a call.
- PR description: under about 150 words unless the change genuinely needs more. Most don't.
- Chat message: if it scrolls, split it or trim it.
When you finish a draft, delete the first sentence and see if anything is lost. Usually it was warmup. Do the same to the last sentence, which is usually a restatement of what you already said.
 
Prefer specifics over description of specifics. "Cuts the bundle by 40kb" beats "significantly improves bundle size."
 
## Formatting that helps a skimmer
 
Structure earns its place when the content is genuinely a list of parallel things, or a set of steps. It does not earn its place as decoration.
 
- Use bullets for actual lists. Three unrelated sentences turned into three bullets is worse than a paragraph.
- Use headers only when the reader will want to jump between sections. A 100-word PR description doesn't need any.
- Default to zero bold.
- If you must use bold, use one short token only (one to three words) and only once in a message.
- Never bold a full sentence or a clause. Never do repeated bold lead-ins across bullets.
- Code, file paths, flags, and identifiers go in backticks. That's real signal, not decoration.

## No emoji
 
Not as bullet markers, not as section icons, not as tone softeners, not one at the end of a sentence to take the edge off.
 
The single exception: when the user explicitly asks for over-the-top kawaii uwu style. That's a deliberate mode, not a default. If they ask, commit fully — that mode is only funny if it's unmistakably intentional. Otherwise, zero.
 
## AI tells to hunt down
 
Treat this as a practical blocklist, not timeless writing theory. Most items below are valid tools in low density; they become tells when they cluster.

List evolves. If a phrase starts showing up everywhere in model outputs, add it. If humans start using it normally, remove it.

### Fast search pass

Run a literal grep pass for these, then rewrite or delete each hit unless the phrase is truly necessary:

- "here's the thing"
- "here's the breakdown"
- "here's what's happening"
- "here's what matters"
- "let me be direct"
- "i'll be honest"
- "great question"
- "good catch"
- "you're absolutely right"
- "that said"
- "to be fair"
- "it's worth noting"
- "worth flagging"
- "it's important to remember"
- "the real problem"
- "what actually matters"
- "not just" (as in "not just X, but Y")
- "in summary"
- "hope this helps"
- "let me know if you have any questions"
- "fails loudly"
- "load-bearing"
- "load bearing"
- "at a high level"
- "going forward"
- "as a reminder"
- "please note"
- "for context"
- "quiet" / "quietly" as a tone adder
- corporate filler: "leverage", "robust", "seamless", "streamline", "utilize", "comprehensive", "nuanced", "multifaceted", "pivotal", "facilitate"
 
### Phrase-level
 
- Em dashes: don't use them. A period, comma, colon, or a pair of parens does the same work. Strongest single giveaway right now, worth a dedicated search-and-destroy pass.
 
- Rule-of-three phrasing: "Fast, reliable, and maintainable." "It's clean, it's typed, and it's tested." Real people list two things, or five, or one. Three balanced items with the rhythm landing on the last is a tic. Cut to the item that matters.
 
- "Not just X, but Y" pivots: also "it's not X, it's Y" and "X isn't just Y, it's Z." Manufactures profundity out of a plain statement. Just say Y.
 
- Degenerate signposts: "Here's the thing." "Here's the breakdown." "Here's what's actually happening." "Here's what matters." "Here's the part most people miss." "Let me be direct." "I'll be honest with you." These announce insight and then deliver ordinary content. Real directness doesn't introduce itself. Delete the signpost, keep the sentence after it, and check that the sentence was worth the buildup.
 
- Validation openers: "Great question!" "Good catch!" "You're absolutely right." "That's a really interesting point." Go straight to substance.
 
- Hedge transitions: "That said," "To be fair," "It's worth noting that," "Worth flagging," "It's important to remember." Almost always deletable with no loss of meaning.
 
- "Quiet" as a weight-adder: quiet confidence, quietly shipping, the quiet truth about X. Sounds thoughtful, says nothing. Currently one of the most reliable one-word tells across every model.
 
- Intensifier crutches: genuinely, actually, truly, simply, "the real problem," "what actually matters." Delete and reread. The sentence is usually stronger.
 
- Corporate vocabulary: leverage (as a verb), robust, seamless, streamline, utilize, comprehensive, nuanced, multifaceted, pivotal, ensure, facilitate. Plain replacements exist for all of them.
 
- Hedge stacks: "This might potentially cause some issues in certain cases." Either it causes issues or you're unsure which. Say which.
 
- Closing summaries and sign-offs: "In summary, this change improves performance while maintaining backwards compatibility." "Let me know if you have any questions!" "Hope this helps!" The reader just read it. Stop when you're done.
 
### Rhythm-level
 
These are harder to catch than word choice, and they're where current models give themselves away even after the obvious phrases are scrubbed.
 
- Fake punchiness: a long winding sentence, then a two-word fragment for impact. Then another one. This is the signature move of the current generation and it's sneakier than flat prose because it looks like variation. When every third line is trying to land a punch, none of them land. One short beat in a document, if the content earns it. Not four.
 
- Metronome sentences: every sentence in the fifteen-to-twenty-word range, every one a complete balanced clause. Human writing is bumpy: a sprawling sentence, then a stub, then two medium ones. If you can read a draft aloud without your breathing changing, the rhythm is flat.
 
- The two-sentence hard cut: "This isn't a style question. It's a correctness question." Same move as "not just X, but Y" in a different coat. Same fix: say the second sentence and drop the first.
 
- Rhetorical question as pivot: "The result? A 40% speedup." "Why does this matter? Because the hook is shared." Zero of these in a PR description is the right number.
 
- Structural symmetry: three bullets under each of three headers, every section the same length, every bullet the same shape. Real changes are uneven, so real writeups about them should be too. A one-line paragraph next to a six-line one reads as a person.
 
- Self-narration: "Two things worth flagging." "One quick note before the details." "I want to be clear about something." Commentary about the shape of the message instead of the message. Say the two things.
 
## Before you hand it over
 
Fast pass, in this order:
 
1. Read the first line alone. Does it carry the point?
2. Search for em dashes. Rewrite each one.
3. Count bold spans. Preferred count is zero. If nonzero, keep one short token only.
4. Any emoji? Unless kawaii mode was requested, delete them.
5. Read the last sentence. Is it a restatement, a sign-off, or an offer to help? Cut it.
6. Look for a triad. Cut it to the item that matters.
7. Grep the phrase list from "Fast search pass" and clean every non-essential hit.
8. Count fragments. More than one one-or-two-word sentence in a short piece is fake punchiness.
9. Eyeball sentence lengths. If they're all about the same, break one and merge two others.
10. Does anything sound like a press release? Swap in the plain word.
One check that catches what the list misses: read it in the voice of a tired senior engineer with 40 unread notifications. Would they read past line one? Would anything in it make them roll their eyes?
