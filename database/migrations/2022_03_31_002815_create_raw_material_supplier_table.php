<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateRawMaterialSupplierTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('raw_material_supplier', function (Blueprint $table) {
            $table->unsignedBigInteger('raw_material_id');
            $table->unsignedBigInteger('supplier_id');
            $table->foreign('raw_material_id')->references('id')->on('raw_materials');
            $table->foreign('supplier_id')->references('id')->on('suppliers');
            $table->float('price_factor');
            $table->integer('quantity_available');
            $table->integer('time_to_deliver');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('raw_material_supplier');
    }
}
