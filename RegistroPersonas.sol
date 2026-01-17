// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RegistroPersonas {
    
    struct Persona {
        string nombre;
        uint edad;
        string direccion;
        bool existe;
    }
    
    mapping(address => Persona) public personas;
    address[] public direccionesRegistradas;
    
    event PersonaRegistrada(address indexed direccion, string nombre, uint edad);
    event PersonaActualizada(address indexed direccion, string nombre, uint edad);
    
    function registrarPersona(string memory _nombre, uint _edad, string memory _direccion) public {
        require(bytes(_nombre).length > 0, "El nombre no puede estar vacio");
        require(_edad > 0 && _edad < 150, "Edad invalida");
        
        if (!personas[msg.sender].existe) {
            direccionesRegistradas.push(msg.sender);
        }
        
        personas[msg.sender] = Persona({
            nombre: _nombre,
            edad: _edad,
            direccion: _direccion,
            existe: true
        });
        
        emit PersonaRegistrada(msg.sender, _nombre, _edad);
    }
    
    function obtenerPersona(address _direccion) public view returns (string memory, uint, string memory) {
        require(personas[_direccion].existe, "Persona no registrada");
        Persona memory p = personas[_direccion];
        return (p.nombre, p.edad, p.direccion);
    }
    
    function obtenerMisDatos() public view returns (string memory, uint, string memory) {
        require(personas[msg.sender].existe, "No estas registrado");
        Persona memory p = personas[msg.sender];
        return (p.nombre, p.edad, p.direccion);
    }
    
    function obtenerTotalRegistros() public view returns (uint) {
        return direccionesRegistradas.length;
    }
}
