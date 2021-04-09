<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDailyStatsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('daily_stats', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->integer("day");
            $table->integer("entreprise_id");
            $table->bigInteger("sales");
            $table->bigInteger("caisse");
            

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('daily_stats');
    }
}
