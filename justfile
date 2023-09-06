update-swagger:
  kubectl get --raw /openapi/v2 > ./api/openapi-spec/swagger.json
  npx prettier -w ./api/openapi-spec/swagger.json
