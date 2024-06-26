# PR Checklist

Please check if your PR fulfills the following requirements
- [ ] The title follows our [guidelines](https://github.com/ideacrew/enroll/blob/trunk/CONTRIBUTING.md#commit)
- [ ] Tests for the changes have been added (for bugfixes/features), they use let helpers and before blocks
- [ ] For all UI changes, there is cucumber coverage
- [ ] Any endpoint touched in the PR has an appropriate Pundit policy. For open endpoints, reasoning is documented in PR and code
- [ ] For all scripts or rake tasks, how to run it is documented on both the PR and in the code
- [ ] There are no inline styles added
- [ ] There are no inline javascript added
- [ ] There is no hard coded text added/updated in helpers/views/Javascript. New/updated translation strings do not include markup/styles, unless there is supporting documentation
- [ ] Code does not use .html_safe
- [ ] All images added/updated have alt text
- [ ] Doesn’t bypass rubocop rules in any way

# PR Type
What kind of change does this PR introduce?

- [ ] Bugfix
- [ ] Feature (requires Feature flag)
- [ ] Data fix or migration (inert code, no impact until run)
- [ ] Refactoring (no functional changes, no API changes)
- [ ] Build related changes
- [ ] CI related changes
- [ ] Dependency updates (e.g., add a new gem or update to a version)

# What is the ticket # detailing the issue?

Ticket: 

# A brief description of the changes

Current behavior:

New behavior:

# Additional Context
Include any additional context that may be relevant to the peer review process.

