@props(['active', 'href', 'path'])

@php
$classes = ($active ?? false)
? 'pl-6 flex gap-3 items-center px-1 pt-1 border-l-8 h-12 border-vert text-md font-medium leading-5 text-vert focus:outline-none focus:border-indigo-700 transition duration-150 ease-in-out'
: 'pl-6 flex gap-3 items-center px-1 pt-1 border-l-8 h-12 border-transparent text-md font-medium leading-5 text-nav hover:text-vert hover:border-vert focus:outline-none focus:border-gray-300 transition duration-150 ease-in-out';
@endphp

<div {{ $attributes->merge(['class' => $classes]) }}>
    <!-- get path from props and add proper icons -->
    <img src="{{ $active ? $path[0] : $path[1] }}" alt="{{ $path[0] ?? '' }} icon" class='w-6 h-6'>
    <a href="{{ $href }}">
        {{ $slot }}
    </a>
</div>