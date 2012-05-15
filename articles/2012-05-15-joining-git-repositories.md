title: Joining Git Repositoires
tags: [git]

At work, we provide an API for our app and maintain web-based
documentation for said API. We originally had the documentation in a
separate git repo, but as it makes much more sense to maintain the docs
directly alongside the code it documents we wanted to merge the two
repositories. This was done in two steps.

### Moving files

First, we need to prep the docs repo such that the content is in a
reasonable location, rather than the root directory. This is done fairly
easily with `git filter-branch` (zsh):

    % mkdir -p doc/api_docs
    % git checkout -b for_transplant # work in a branch for safety
    % for file in <files/dirs to move>;
          do git filter-branch --tree-filter \
            "test -e $file && mv $file doc/api_docs || echo skip" \
            HEAD;
          done

This goes through out commit history, and runs through each commit
moving old content into a subdirectory. It's slow in that it does a full
history pass for each file, but I didn't care to figure out how to move
everything _except_ the docs directory.

### Merging the repos

First, for clarity, let's make a new branch based off of the original
commit in our destination repo:

    % git log --oneline | tail -n 1
    e7c9feb Initial commit
    % git checkout e7c9feb
    % git checokut -b doc_import

First, prepare the main repo for the incoming transplant by cloning a
bare copy (git refuses to pull an external repo into a normal checkout).

    % git clone --bare git@github.com:example/myapp.git myapp-bare

We can then pull in the commit objects from the other repository:

    % cd myapp-bare
    % git fetch -f ../api_doc_site for_transplant:api_docs

The -f tells git to ignore the different initial commits, and then we
explicitly specify the remote and local branches to move commits to. You
might need to resolve a merge conflict at this point, if for example
both repositories committed a different `.gitignore` in their initial
commit.

We can now go back to our regular repo and pull those branches in:

    % cd ../myapp
    % git remote add bare ../myapp-bare
    % git pull bare api_docs

Finally, merging that branch into master gets things all up-to-date, and
we can start unified work while maintaining the full original history of
the documentation.

