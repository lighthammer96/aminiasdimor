@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')

    @include('uniones.form')
    @include('paises.form')
    @include('idiomas.form')
    @include('divisiones.form')
@endsection
