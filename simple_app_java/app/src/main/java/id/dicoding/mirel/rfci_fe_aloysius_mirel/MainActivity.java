package id.dicoding.mirel.rfci_fe_aloysius_mirel;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class MainActivity extends AppCompatActivity {
    private boolean waitDouble = true;
    private static final int DOUBLE_CLICK_TIME = 350; // double click timer
    EditText edtName;
    HashMap<Character, Integer> charCountMap;
    TextView txtOutput;
    Button btnReverse, btnUndoRedo;
    String undo,redo;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        edtName = findViewById(R.id.edt_name);
        txtOutput = findViewById(R.id.txt_output);
        btnReverse = findViewById(R.id.btn_reverse);
        btnUndoRedo = findViewById(R.id.btn_undoredo);
        charCountMap = new HashMap<>();

        edtName.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {
            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void afterTextChanged(Editable editable) {
                undo = edtName.getText().toString();
            }
        });




        btnReverse.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!edtName.getText().toString().isEmpty()) {
                    StringBuffer x = new StringBuffer(edtName.getText().toString());
                    txtOutput.setText(x.reverse());
                    Toast.makeText(MainActivity.this, "Success!", Toast.LENGTH_LONG).show();
                } else {
                    edtName.setError("Enter Word");
                }

            }
        });

        btnUndoRedo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (waitDouble) {
                    waitDouble = false;
                    Thread thread = new Thread() {
                        @Override
                        public void run() {
                            try {
                                sleep(DOUBLE_CLICK_TIME);
                                if (waitDouble == false) {
                                    waitDouble = true;
                                    Log.d("Aloysius Mirel","Single Click");

                                }
                            } catch (InterruptedException e) {
                                e.printStackTrace();
                            }
                        }
                    };
                    thread.start();
                } else {
                    waitDouble = true;
                    edtName.setText("");
                    Log.d("Aloysius Mirel","Double Click");
                }
            }
        });
    }
}