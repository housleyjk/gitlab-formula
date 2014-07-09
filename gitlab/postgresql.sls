include:
  - gitlab.gitlab

postgresql-server:
  pkg.installed:
    names:
      - postgresql-9.3
      - postgresql-dev-9.3
      - postgresql-server-9.3
      - postgresql-client-9.3
  service.running:
    - name: postgresql

gitlab-db:
  postgres_user.present:
    - name: {{ salt['pillar.get']('gitlab:db_user') }}
    - password: {{ salt['pillar.get']('gitlab:db_pass') }}
    - require:
      - pkg: postgresql-server
      - service: postgresql-server
  postgres_database.present:
    - name: {{ salt['pillar.get']('gitlab:db_name') }}
    - owner: {{ salt['pillar.get']('gitlab:db_user') }}
    - template: template1
    - require:
      - file: gitlab-service
      - pkg: postgresql-server
      - service: postgresql-server
      - postgres_user: gitlab-db
