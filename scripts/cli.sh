#!/bin/bash
# Updates `content/reference/api/cli.md` from the locally installed go-ipfs

exec &> ./content/reference/api/cli.md

echo "---
title: \"CLI Commands\"
identifier: clicommands
weight: 10
menu:
    reference:
        parent: api
---

<!-- TODO: Remove index since it's handled by the TOC in the menu? -->
<!-- TODO: Structure this around command groups (dag, object, files, etc.) -->

**Note:** IPFS can run in either “online” (you have IPFS running separately as a daemon process) or “offline” mode, but some commands are only supported when online. For example \`ipfs swarm peers\` only works in online mode because you won’t be connected to a swarm at all if you’re offline. For more about running IPFS as a daemon, see [“going online” in the usage documentation]({{< relref \"usage.md#going-online\" >}}).
"

echo "*Generated on $(date +"%Y-%m-%d %T"), from go-ipfs $(ipfs version -n).*"
printf "\n"
ipfs commands | while read line ; do
  echo "- [$line](#$(echo $line | tr -s ' ' -))"
done
printf "\n"
ipfs commands | while read line ; do
  printf "## $line\n\n\`\`\`\n"
  $line --help
  printf "\`\`\`\n\n"
done
