<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateStock extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('stock', function (Blueprint $table) {
            $table->unsignedBigInteger('entreprise_id');
            $table->unsignedBigInteger('product_id');
            $table->float('quantity');
            $table->integer("phase")->default(0);
            $table->foreign('entreprise_id')->references('id')->on('users');
            $table->foreign('product_id')->references('id')->on('products');
            $table->primary(['entreprise_id','product_id','phase']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('stock');
    }
}
