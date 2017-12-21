package hk.gov.ogcio.wcag.adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.ArrayList;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.gson.Seminar;

public class SeminarListAdapter extends RecyclerView.Adapter<SeminarListAdapter.ViewHolder> implements View.OnClickListener {

    private ArrayList<Seminar> arrayList;
    private Context context;
    private OnItemClickListener onItemClickListener;

    public SeminarListAdapter(Context context, ArrayList<Seminar> arrayList) {
        this.context = context;
        this.arrayList = arrayList;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup viewGroup, int position) {
        View view = LayoutInflater.from(context).inflate(R.layout.recyclerview_seminar_list, viewGroup, false);
        view.setOnClickListener(this);
        view.setTag(position);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder viewHolder, int position) {
        Seminar seminar = arrayList.get(position);
        viewHolder.textViewDate.setText(seminar.getDate(context));
        viewHolder.textViewTopic.setText(seminar.getTopic(context));
    }

    @Override
    public int getItemViewType(int position) {
        return position;
    }

    @Override
    public int getItemCount() {
        return arrayList.size();
    }

    @Override
    public void onClick(View view) {
        if (onItemClickListener != null) {
            onItemClickListener.onItemClick(view, (int) view.getTag(), arrayList.get((int) view.getTag()));
        }
    }

    public void setOnItemClickListener(OnItemClickListener onItemClickListener) {
        this.onItemClickListener = onItemClickListener;
    }

    public interface OnItemClickListener {
        void onItemClick(View view, int position, Seminar seminar);
    }

    class ViewHolder extends RecyclerView.ViewHolder {

        private TextView textViewDate;
        private TextView textViewTopic;

        ViewHolder(View view) {
            super(view);
            textViewDate = view.findViewById(R.id.textViewDate);
            textViewTopic = view.findViewById(R.id.textViewTopic);
        }
    }
}