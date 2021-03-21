<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCommandsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('commands', function (Blueprint $table) {
            $table->integer("command_id");
            $table->unsignedBigInteger('supplier_id');
            $table->unsignedBigInteger('entreprise_id');
            $table->unsignedBigInteger('raw_material_id');
            $table->float('quantity')->nullable();
            $table->float('price')->nullable();
             $table->timestamps();
            $table->foreign('entreprise_id')->references('id')->on('users');
            $table->foreign('supplier_id')->references('id')->on('users');
            $table->foreign('raw_material_id')->references('id')->on('raw_materials');
            $table->primary(['command_id','raw_material_id']);

           
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('commands');
    }
}
