import { $ } from "https://deno.land/x/zx_deno/mod.mjs";

type Path = string;
type Url = string;

type SwaggerV3 = {
  paths: Record<
    Path,
    {
      serverRelativeURL: Url;
    }
  >;
};

const res = await $`kubectl get --raw /openapi/v3`;
const source = JSON.parse(res.toString()) as SwaggerV3;

for (let path in source.paths) {
  const swaggerFilePath = `./api/openapi-spec/v3/${path}/swagger.json`;
  await $`mkdir -p $(dirname ${swaggerFilePath})`;
  const res = await $`kubectl get --raw /openapi/v3/${path}`;
  await Deno.writeTextFile(swaggerFilePath, res.toString());
}
