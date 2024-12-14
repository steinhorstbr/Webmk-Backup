<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\DeviceSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Dispositivos';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="device-index">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Crie um dispositivo', ['create'], ['class' => 'btn btn-success']) ?>
        <?= Html::a('Iniciar backup manualmente', ['backupall'], ['class' => 'btn btn-warning']) ?>
        <?php
            if(Yii::$app->request->get('resultn8n') == "OK"){
               echo Html::tag('div', 'Solicitação enviada com sucesso', ['class' => 'alert alert-success']);
            } elseif(Yii::$app->request->get('resultn8n') == "FAIL") {
               echo Html::tag('div', 'Erro ao enviar solicitação', ['class' => 'alert alert-danger']);
            }
        ?>
    </p>

    <?php //echo $this->render('_search', ['model' => $searchModel]); ?>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id',
            'name',
            'ip_address',
            'sshport',
            'username',
            [
                'attribute' => 'laststatus',
                'contentOptions'=>function ($data) {
                    return $data->laststatus == "BAD" ? array('style'=>'color: red') : array('style'=>'color: green');
                },
                'filter' => array("OK"=>"OK","BAD"=>"BAD"),
            ],
            'active:boolean',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>


</div>
