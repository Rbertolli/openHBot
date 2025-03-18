#!/bin/bash
set -e

mkdir -p src public

cat > composer.json <<'EOF'
{
    "name": "rbertolli/openhbot",
    "description": "Pacote open source para o projeto openHBot",
    "type": "library",
    "license": "MIT",
    "autoload": {
        "psr-4": {
            "RBertolli\openHBot\": "src/"
        }
    },
    "require": {}
}
EOF

cat > .gitignore <<'EOF'
vendor/
composer.lock
credentials.php
.env
EOF

cat > app.yaml <<'EOF'
name: openHBot
services:
  - name: openhbot-service
    github:
      repo: Rbertolli/openHBot
      branch: master
    environment_slug: php
    build_command: "composer install --no-dev"
    run_command: "php -S 0.0.0.0:$PORT -t public"
    env_vars:
      - key: API_KEY
        value: "sua_chave_api_aqui"
      - key: API_SECRET
        value: "seu_segredo_api_aqui"
      - key: APP_ENV
        value: "production"
EOF

mkdir -p public src

cat > public/index.php <<'EOF'
<?php
require __DIR__ . '/../vendor/autoload.php';
use RBertolli\openHBot\Webhook;
$webhook = new Webhook();
echo $webhook->handle();
EOF

cat > src/Webhook.php <<'EOF'
<?php
namespace RBertolli\openHBot;
class Webhook {
    public function handle(){
        return "Webhook processado com sucesso!";
    }
}
EOF

cat > src/Retorno.php <<'EOF'
<?php
namespace RBertolli\openHBot;
class Retorno {
    public function process(){
        return "Retorno processado!";
    }
}
EOF

cat > src/Config.php <<'EOF'
<?php
namespace RBertolli\openHBot;
class Config {
    private $credentials;
    public function __construct(){
        $this->credentials = [
            'api_key' => getenv('API_KEY'),
            'api_secret' => getenv('API_SECRET')
        ];
    }
    public function get($key){
        return $this->credentials[$key] ?? null;
    }
}
EOF

if command -v composer >/dev/null 2>&1; then
    composer dump-autoload
fi

echo "Setup concluído."

