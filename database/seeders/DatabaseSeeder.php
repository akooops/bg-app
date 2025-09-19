<?php

namespace Database\Seeders;

use App\Models\Admin;
use Illuminate\Support\Facades\Hash;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // \App\Models\User::factory(10)->create();

        Admin::create([
            'name' => 'Admin User',
            'email' => 'admin@bg.iec',
            'password' => Hash::make('admin123'),
            'type' => 'admin',
            'email_verified_at' => now()
        ]);
    }
}
