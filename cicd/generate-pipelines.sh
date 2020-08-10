#!/bin/bash

# only supports this inventory structure right now: https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#alternative-directory-layout
# will need some more logic to support the other (primary?) style

SITES=`ls ./automation/inventories`

for SITE in $SITES
do
# now generate the whole CI pipeline for the site
# only two vars for the template right now and we need to do better in dynamically determining (or storing) the topology_definition_file since we need it for the topology_converter build stage
export site=$SITE
export topology_definition_file="cldemo2.dot"
#
j2 ./cicd/.gitlab-ci-template.j2 > ${SITE}-pipeline.yml

done

