<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateRawMaterialsStock extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('raw_materials_stock', function (Blueprint $table) {
            $table->unsignedBigInteger('entreprise_id');
            $table->unsignedBigInteger('raw_material_id');
            $table->float('quantity');
            $table->string('unit')->nullable();
            $table->integer("phase")->default(0);
            $table->foreign('entreprise_id')->references('id')->on('users');
            $table->foreign('raw_material_id')->references('id')->on('raw_materials');
            $table->primary(['entreprise_id','raw_material_id','phase']);

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('raw_materials_stock');
    }
}
