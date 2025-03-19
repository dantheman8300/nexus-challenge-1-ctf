module ctf::vault {

  use ctf::key;
  use ctf::flag;

  public struct Vault has key {
    id: UID,
    code: u64
  }
  
  public fun new(
    code: u64,
    ctx: &mut TxContext
  ) {
    let new_vault = Vault {
      id: object::new(ctx),
      code
    };

    transfer::share_object(
      new_vault
    );
  }

  public fun withdraw(vault: &mut Vault, key: key::Key, ctx: &mut TxContext): flag::Flag {
    assert_valid_key_code(vault, &key);
    key::delete(key);

    flag::new(b"vault".to_string(), ctx)
  }

  fun assert_valid_key_code(vault: &Vault, key: &key::Key) {
    assert!(vault.code == key::get_code(key));
  }

}