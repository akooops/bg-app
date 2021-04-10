<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __("Liste des demandes d'endettements") }}
        </h2>
    </x-slot>
<EntrepriseLoanListing v-bind:entreprise="{{auth()->user()}}" :caisse="{{$caisse}}"/>
</x-app-layout>