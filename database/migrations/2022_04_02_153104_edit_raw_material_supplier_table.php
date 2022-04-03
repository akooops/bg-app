<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class EditRawMaterialSupplierTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('raw_material_supplier', function (Blueprint $table) {
            $table->dropColumn("quantity_available");
            $table->boolean("is_available")->default(true);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('raw_material_supplier', function (Blueprint $table) {
            $table->integer('quantity_available');
            $table->dropColumn("is_available");
        });
    }
}
