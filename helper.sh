#!/bin/bash

deploy_crds() {
  verb=create
  if [ "$1" == "del" ]
  then
    verb=delete
  fi
  oc $verb -f deploy/crds/lb.nginx.com_components_crd.yaml
  oc $verb -f deploy/crds/lb.nginx.com_certificates_crd.yaml
  oc $verb -f deploy/crds/lb.nginx.com_gateways_crd.yaml
  oc $verb -f deploy/crds/lb.nginx.com_applications_crd.yaml
  oc $verb -f deploy/crds/lb.nginx.com_controllers_crd.yaml
}

deploy_oper() {
  verb=create
  if [ "$1" == "del" ]
  then
    verb=delete
  fi
  oc $verb -f deploy/operator-for-reals.yaml
}

case $1 in 
  setup)
    deploy_crds
    deploy_oper
    ;;
  cleanup)
    deploy_crds del
    deploy_oper del
    ;;
  *)
    echo "$0 [setup|cleanup]"
    ;;
esac
