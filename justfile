update-swagger:
  #!/bin/sh
  kind delete cluster --name openapi
  kind create cluster --name openapi

  # appthrust/appthrustをこんな感じでcloneしておく
  # ├── appthrust (appthrust/appthrust)
  # └── openapi (labthrust/openapi)
  just --justfile ../appthrust/justfile install-all-crds

  mkdir -p ./api/openapi-spec/v2
  kubectl get --raw /openapi/v2 > ./api/openapi-spec/swagger.json
  kubectl get --raw /openapi/v2 > ./api/openapi-spec/v2/swagger.json
  deno run --allow-write --allow-read --allow-env --allow-run --allow-net=deno.land  ./scripts/gen.ts
  npx prettier -w ./api/openapi-spec/
  kind delete cluster --name openapi
