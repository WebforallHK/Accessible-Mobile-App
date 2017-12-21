package hk.gov.ogcio.wcag.adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.HashMap;

import hk.gov.ogcio.wcag.R;

public class VideoListAdapter extends RecyclerView.Adapter<VideoListAdapter.ViewHolder> implements View.OnClickListener {

    private ArrayList<HashMap<String, Object>> arrayList;
    private Context context;
    private OnItemClickListener onItemClickListener;

    public VideoListAdapter(Context context, ArrayList<HashMap<String, Object>> arrayList) {
        this.context = context;
        this.arrayList = arrayList;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup viewGroup, int position) {
        View view = LayoutInflater.from(context).inflate(R.layout.recyclerview_video_list, viewGroup, false);
        view.setOnClickListener(this);
        view.setTag(position);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder viewHolder, int position) {
        viewHolder.textView.setText((CharSequence) arrayList.get(position).get("title"));
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
        void onItemClick(View view, int position, HashMap<String, Object> hashMap);
    }

    class ViewHolder extends RecyclerView.ViewHolder {

        private TextView textView;

        ViewHolder(View view) {
            super(view);
            textView = view.findViewById(R.id.textView);
        }
    }
}