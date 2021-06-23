@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')
    @include('iglesias.form')
    @include('distritos_misioneros.form')
    @include('misiones.form')
    @include('uniones.form')
    @include('paises.form')
    @include('idiomas.form')
    @include('divisiones.form')
@endsection

