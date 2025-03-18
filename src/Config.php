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
