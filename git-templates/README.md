Add `prepare-commit-msg` into `hooks/`

```bash
#!/bin/bash

JIRA_TAG=$(git rev-parse --abbrev-ref HEAD | grep -oP '[A-Z]{2,3}-\d+' | head -n1)

if [ -n "$JIRA_TAG" ] &&  [[ ! "$(head -n1 $1)" =~ ^$JIRA_TAG ]] ; then
	sed -i.bak -e "1s/^/$JIRA_TAG /" $1
fi
```
