@props(['active','name','link'])

@php
$class= ($active ?? false) ? 'text-white bg-vert' : 'text-vN bg-transparent ';
@endphp


<div class="flex text-xl rounded-3xl font-medium my-auto justify-center py-2 px-3 {{$class}} hover:bg-vert hover:text-white">
   <a href="{{$link}}">{{$name}}</a> 
</div>