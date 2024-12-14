<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "devices".
 *
 * @property int $id
 * @property string $name
 * @property string $ip_address
 * @property string $username
 * @property string $password
 */
class Device extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'device';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name', 'ip_address', 'sshport', 'username'], 'required'],
            [['password'], 'required', 'when' => function($model) {return $model->sshuse == '0';}, 'enableClientValidation' => false],
            [['sshkey'], 'required', 'when' => function($model) {return $model->sshuse == '1';}, 'enableClientValidation' => false],
            [['name', 'ip_address', 'sshport', 'username', 'sshkey'], 'trim'],
            [['sshport'], 'number', 'max' => 65535],
            [['sshkey'], 'match', 'pattern' => '/^-----BEGIN OPENSSH PRIVATE KEY-----\s[\s\S]+?\s-----END OPENSSH PRIVATE KEY-----$/'],
            [['password'], 'string'],
            [['name', 'username'], 'string', 'max' => 100],
            [['ip_address'], 'ip', 'ipv6' => false, 'subnet' => false],
            [['active', 'sshuse'], 'boolean'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => 'Nome',
            'ip_address' => 'IP',
            'sshport' => 'Porta SSH',
            'username' => 'Nome / Usuario',
            'sshuse' => 'Usar chave SSH?',
            'password' => 'Senha',
            'sshkey' => 'Chave SSH privada',
            'active' => 'Ativo?',
            'laststatus' => 'Estado mais recente',
            'lastok' => 'Última tentativa bem sucedida',
            'lastbad' => 'Última tentativa com erro',
        ];
    }
}
