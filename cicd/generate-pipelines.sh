#!/bin/bash

# only supports this inventory structure right now: https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#alternative-directory-layout
# will need some more logic to support the other (primary?) style

SITES=`ls ./inventories`

for SITE in $SITES
do
# now generate the whole CI pipeline for the site
# only two vars for the template right now and we need to do better in dynamically determining (or storing) the topology_definition_file since we need it for the topology_converter build stage
export site=$SITE
# todo: improve this for portability make it more dynamic or centralize it with other vars.
export topology_definition_file="cldemo2.dot"
#
j2 ./cicd/.gitlab-ci-template.j2 > ${SITE}-pipeline.yml

done

