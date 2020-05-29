# frozen_string_literal: true

f = "#{DebugsBunny::ROOT_DIR}/lib/debugs_bunny/tasks/trace.rake"
load f

# rubocop:disable RSpec/DescribeClass
RSpec.describe 'debugs_bunny:delete_expired_traces', type: :task do
  let(:task) { subject }

  describe 'debugs_bunny:delete_expired_traces' do
    before do
      create_list :debug_trace, 5
      create_list :debug_trace, 5, created_at: 3.days.ago
    end

    after do
      DebugsBunny.configuration.max_age = DebugsBunny.default_configuration.max_age
    end

    it 'deletes all expired traces' do
      DebugsBunny.configuration.max_age = 1.day
      expect do
        run_task
      end.to change(DebugTrace, :count).by(-5)
    end

    it 'does not delete traces that have not expired' do
      DebugsBunny.configuration.max_age = 1.week
      expect do
        run_task
      end.not_to change(DebugTrace, :count)
    end
  end
end
# rubocop:enable RSpec/DescribeClass
