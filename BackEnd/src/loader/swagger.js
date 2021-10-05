import swaggerUi from 'swagger-ui-express'
import swaggereJsdoc from 'swagger-jsdoc'
import YAML from 'yamljs'

const swaggerDocument = YAML.load('./docs/index.yaml');

const options = {
    definition: swaggerDocument,
    apis: ['./docs/*.yaml', './docs/*/*.yaml'],
};

const specs = swaggereJsdoc(options);

export default [
    swaggerUi.serve,
    swaggerUi.setup(specs)
];