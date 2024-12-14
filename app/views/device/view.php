<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model app\models\Device */

$this->title = $model->name;
$this->params['breadcrumbs'][] = ['label' => 'Dispositivos', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="device-view">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Mudar', ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Excluir', ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => 'Tem certeza de que deseja remover este dispositivo??',
                'method' => 'post',
            ],
        ]) ?>
        <?= Html::a('Faça um backup do dispositivo', ['backupone', 'id' => $model->id], ['class' => 'btn btn-warning']) ?>
        <?= Html::a('Teste de conexão', ['view', 'id' => $model->id, 'testconn' => 1], ['class' => 'btn btn-info']) ?>

        <?php
            if(Yii::$app->request->get('testconn') == 1){
              echo Yii::$app->n8n->get('testconnection', ['id' => $model->id])->send()->content;
            }
        ?>
        <?php
            if(Yii::$app->request->get('resultn8n') == "OK"){
              echo Html::tag('div', 'Solicitação enviada com sucesso', ['class' => 'alert alert-success']);
            } elseif(Yii::$app->request->get('resultn8n') == "FAIL") {
              echo Html::tag('div', 'Erro ao enviar solicitação', ['class' => 'alert alert-danger']);
            }
        ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            'name',
            'ip_address',
            'sshport',
            'username',
            [
                'attribute' => 'laststatus',
		'contentOptions' => ['style' => ($model->laststatus == "BAD") ? 'color: red' : 'color: green'],
            ],
            'sshuse:boolean',
            'active:boolean',
            'lastok:datetime',
            'lastbad:datetime',
        ],
    ]) ?>

        <?php
            if(Yii::$app->request->get('downloaderror') == "true"){
               echo Html::tag('div', 'Erro ao receber arquivo para download', ['class' => 'alert alert-danger']);
            }
        ?>
        <?= Html::a('Baixe o backup binário mais recente', ['downloadbin', 'id' => $model->id, 'name' => $model->name], ['class' => 'btn btn-success']) ?>
        <?= Html::a('Baixe o backup de exportação mais recente', ['downloadrsc', 'id' => $model->id, 'name' => $model->name], ['class' => 'btn btn-success']) ?>

</div>
