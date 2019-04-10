---
title: Git Rebase by Example
tags: [git]
---

Today at work, I determined that my current work in progress branch was going to want to be merged into production ahead of our next scheduled merge/deploy of master. To make it easier to merge into our production branch for a hot-fix deploy, I want to have the branch based off production instead of master.

So, I could do this manually:

    $ git reset HEAD~ # move HEAD commit back to staging
    $ git stash save # move uncommited changes to stash
    # repeat until all my changes are in stash
    $ git checkout production
    $ git stash pop
    $ git commit ...
    # again, repeat until complete

However, this is a pain in the neck because it’s all manual, and it loses the commit metadata (timestamps, but also author info if you’re moving commits from multiple people). Also, because I prefer small merges to big merges, I've merged master into my branch a few times, and that means deciding to commit or wipe commits.

Instead, let's git do all the work, and use `git rebase` to move my commits to their new home, and also filter out those merges.

Before getting started, we should backup my branch, by just doing a `git checkout -b wip-rebase`. Then, to confirm exactly what my changes were we can run `git cherry -v origin/master`. This will list all the commits on the current branch that are not on the specified branch.

Then, I want to start by getting rid of all my extra merges, and filter the branch to just these outbound changes. For this we'll do an interactive rebase: `git rebase -i acfad~`, where acfad is the commit hash at the top of my change list (you can also just use a visual git browser or whatever to find the base commit for your changes). This will pop open an editor, and let me decide exactly how I want to handle each commit.

This is a powerful tool, and all its options are beyond the scope of this article, but it will let you do anything from editing a commit message, to combining or reordering commits, to executing shell commands between specific commits.

Here, we're just dropping commits, so we can scroll down the editor here and any commit that wasn't listed in our `git cherry` output we can change the `pick` to `drop`. Or, even easier, delete the line.

Now save and quit the editor, and git will do its job. We can verify with another `git cherry -v origin/master` and compare output now with earlier output. Note that our oldest commits are unchanged, but the commit hash for the newer ones is changed. This is because the hash of a commit depends on the hashes of its parents, and by deleting merged commits from our history we are of course unable to use them as parents anymore. Also, looking directly at the `git log` we can see that deleting all commits from one branch of a merge commit will also delete the merge itself. For our purposes, as long as the commit messages in both `git cherry` outputs are the same, then we're doing fine.

Now that the busy work is behind us, we can get to the actual goal of moving the commits. The command for this will be `git rebase --onto origin/production acfad~` -- again we're referring to the parent of the first commit in our branch.

This is the part that works exactly as I described above, git is "rewinding head to replay your work on top of it". As with any merge (applying a commit in a changed context) you can expect to see some conflicts and can resolve them as usual. However when done, instead of commiting we'll move on with `git rebase --continue`. If at any time things get confused and you make a mistake, `git rebase --abort` will roll you back to your branch as it was before rebasing.

Once you're done with the conflicts, `git` will finalize the rebase behind the scenes, and leave you back at your current branch having updated the root parent, and touched all the commits on the way down. We can confirm this with a final `git cherry -v origin/master`.

Now is a good time to run specs (or let CI work that for you) and do whatever other testing you need to confirm everything functions as it should.