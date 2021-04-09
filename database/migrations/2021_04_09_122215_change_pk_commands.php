<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class ChangePkCommands extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('commands', function (Blueprint $table) {
            $table->dropPrimary(['command_id','raw_material_id']);
            $table->integer("item_id");
            $table->primary(['command_id','raw_material_id',"item_id"]);
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
            $table->dropPrimary(['command_id','raw_material_id','item_id']);
            $table->dropColumn("item_id");
            
        });
    }
}
