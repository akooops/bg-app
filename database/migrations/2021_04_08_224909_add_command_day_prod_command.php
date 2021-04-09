<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddCommandDayProdCommand extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('commands', function (Blueprint $table) {
            $table->integer("creation_date")->default(0);
        });
        Schema::table('productions', function (Blueprint $table) {
            $table->integer("creation_date")->default(0);
        });
        
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('commands', function (Blueprint $table) {
            $table->dropColumn('creation_date');
        });
        Schema::table('productions', function (Blueprint $table) {
            $table->dropColumn('creation_date');
        });
    }
}
