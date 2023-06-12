@@ -72,21 +72,24 @@ contract AccessControlLearning {
    //    Continúa con el otro elemnto "_ñ"
    modifier onlyRole(bytes32 _role) {
        // Roles temporales
        // require(hasRole, "Cuenta no tiene el rol necesario");
        //require(hasRole, "Cuenta no tiene el rol necesario");
        _;
    }

    // 6.
    // event TransferOwnership
    // event RenounceOwnership
    event TransferOwnership(address prevOwner, address newOwner);
    event RenounceOwnership(address owner);

    // 1. definir un mapping doble para guardar datos en una matriz
    // mapping 1 -> address => role
    // mapping 2 -> role => boolean
    mapping(address operador => mapping(bytes32 nombreRol => bool siTieneRolNo)) private roles;

    // 5. utilizar el constructor para inicializar valores
    constructor() {
        // _roles[msg.sender][DEFAULT_ADMIN_ROLE] = true;
        roles[msg.sender][DEFAULT_ADMIN_ROLE] = true;
    }

    // 2. definir metodo de lectura de datos de la matriz llamado 'hasRole'
@@ -96,24 +99,45 @@ contract AccessControlLearning {
    //     public
    //     view
    //     returns (bool);
    function hasRole(
        address _account,
        bytes32 _role
    ) public view returns (bool) {
        return roles[_account][_role];
    }

    // 3. definir método para escribir datos en la matriz llamado 'grantRole'
    //    metodo protegido por el modifier 'onlyRole(DEFAULT_ADMIN_ROLE)'
    //    método público, puede ser heredado. es de escritura
    // function grantRole(address _account, bytes32 role) public;
    function grantRole(
        address _account,
        bytes32 _role
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        roles[_account][_role] = true;
    }

    // 6. Crear un método que se llame 'transferOwnership(address _newOwner)'
    //    Recibe un argumento: el address del nuevo owner
    //    Solo Puede ser llamado por una cuenta admin
    //    La cuenta admin transfiere sus derechos de admin a '_newOwner'
    //    Dispara el evento 'TransferOwnership(address _prevOwner, address _newOwner)'
    // function transferOwnership(address _newOwner) public;
    function transferOwnership(address _newOwner) public onlyRole(DEFAULT_ADMIN_ROLE){
        require(_newOwner != address(0), "Invalid new owner address");
        address _prevOwner = msg.sender;
        roles[_prevOwner][DEFAULT_ADMIN_ROLE] = false;
        roles[_newOwner][DEFAULT_ADMIN_ROLE] = true;
        emit TransferOwnership( _prevOwner, _newOwner);
    }

    // 7. Crear un método lalmada 'renounceOwnership'
    //    La cuenta que lo llama es una cuenta admin
    //    Esta cuenta renuncia su derecho a ser admin
    //    Dispara un evento RenounceOwnership(msg.sender)
    // function renounceOwnership() public;
    function renounceOwnership() public onlyRole(DEFAULT_ADMIN_ROLE){
        roles[msg.sender][DEFAULT_ADMIN_ROLE] = false;
        emit RenounceOwnership(msg.sender);
    }

    // 8. Crear un método llamado 'grantRoleTemporarily'
    //    Este metodo solo es llamado por una cuenta 'admin'
