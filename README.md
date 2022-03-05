## Getting Started :
To properly run a simulation you should launch several commands which are : 

1. The actual server using `php artisan serve`.

2. Building the js, while developing you can use `npm run hot`, in prod you should use `npm run prod`.

3. Launching the scheduler, `php artisan schedule:work`, the settings of the Scheduled jobs can be found in `app/Console/Kernel.php` which is responsible on running the following jobs :  
    - Adding the game timer each minute (there will be no output in the cli).
     
    - Calculating and adding the penalty loans, it runs each minute but it will check if there's really a penalty, you will read 'Running scheduled command: App\Jobs\PenaltyLoan' in the cli.
     
    - Calculating and removing the monthly costs (salaries, etc.). The problem is that the job runs at half past (:30) or at :00. So imagine starting the simulation at 13:28, at 13:30 the monthly costs will be calculated, you can make a logic using the simulation day.

4. In order to start the queues, you should run the command `php artisan queue:listen`, this command is responsible of firing events through sockets (indicating that the time changed, a request to a supplier has been made, etc).

5. Start Laravel echo server using `laravel-echo-server start`. The server is reponsible of subscribing the users to their channel (subscribing all users to the timer_change to listen to the changes, etc).

6. For those who are using Windows, you should start the Redis server.

In order to start a simulation you should tick the checkbox `Simulation en cours ?` in Nova. You can set the start date of the game by entering and int (it should be 1). 

Before a simulation you should clear the queues using the command `php artisan queue:clear`.

I think that you don't need the `php artisan queue:work` command. 

Good Luck ! 
