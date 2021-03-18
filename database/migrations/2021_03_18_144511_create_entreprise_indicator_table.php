<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEntrepriseIndicatorTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('entreprise_indicator', function (Blueprint $table) {
            $table->increments('id');
            $table->integer("entreprise_id");
            $table->integer("indicator_id");
            $table->float("value")->nullable();
            $table->integer("phase")->default(0);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('entreprise_indicator', function (Blueprint $table) {
            Schema::dropIfExists('indicators');
        });
    }
}
