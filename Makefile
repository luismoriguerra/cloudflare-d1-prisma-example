
create_app:
	npm create cloudflare@latest prisma-d1-example -- --type hello-world

install_prisma:
	npm install prisma --save-dev
	npm install @prisma/client
	npm install @prisma/adapter-d1

init_prisma:
	npx prisma init --datasource-provider sqlite

create_db:
	npx wrangler d1 create prisma-demo-db


db_migrate_01:
	npx wrangler d1 migrations create prisma-demo-db create_user_table

db_migrate_02:
	npx prisma migrate diff --from-empty --to-schema-datamodel ./prisma/schema.prisma --script --output migrations/0001_create_user_table.sql


db_migrate_03:
	npx wrangler d1 migrations apply prisma-demo-db --local

db_migrate_03_remote:
	npx wrangler d1 migrations apply prisma-demo-db --remote

db_test_data:
	npx wrangler d1 execute prisma-demo-db --command "INSERT INTO  \"User\" (\"email\", \"name\") VALUES ('jane@prisma.io', 'Jane Doe (Local)');" --local


prisma_generate_types:
	npx prisma generate


db_migrate_add_column:
	npx wrangler d1 migrations create prisma-demo-db add_new_column_to_user
	npx prisma migrate diff --from-schema-datamodel ./prisma/schema.prisma.backup --to-schema-datamodel ./prisma/schema.prisma --script --output migrations/0002_add_new_column_to_user.sql

db_run_migration_local:
	npx wrangler d1 migrations apply prisma-demo-db --local

db_run_migration_remote:
	npx wrangler d1 migrations apply prisma-demo-db --remote

