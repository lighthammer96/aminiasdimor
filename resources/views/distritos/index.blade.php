@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')
    @include('distritos.form')

    @include('provincias.form')
    @include('departamentos.form')
    @include('paises.form')
    @include('idiomas.form')
    @include('divisiones.form')
   
@endsection

