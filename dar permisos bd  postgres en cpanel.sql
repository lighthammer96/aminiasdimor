
GRANT CONNECT ON DATABASE iglesia_aminiasdimor TO iglesia_user; 

GRANT USAGE ON SCHEMA public TO iglesia_user;
GRANT USAGE ON SCHEMA iglesias TO iglesia_user;
GRANT USAGE ON SCHEMA seguridad TO iglesia_user;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO iglesia_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA iglesias TO iglesia_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA seguridad TO iglesia_user;


-- GRANT ALL PRIVILEGES ON DATABASE iglesia_aminiasdimor TO iglesia_user; -- no funciono

GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO iglesia_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA iglesias TO iglesia_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA seguridad TO iglesia_user;


-- referencia: https://www.it-swarm-es.com/es/postgresql/dar-todos-los-permisos-un-usuario-en-una-base-de-datos/1044566155/