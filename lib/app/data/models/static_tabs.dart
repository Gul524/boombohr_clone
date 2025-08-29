// predefined_tabs.dart
import 'package:demo_app/app/data/models/models.dart';
import 'package:get/get.dart';

class PredefinedTabs {
  static List<TabModel> generatePredefinedTabs() {
    return [
      _createProfileTab(),
      _createJobTab(),
      _createTrainingTab(),
      _createTimeOffTab(),
      _createDocumentsTab(),
      _createBenefitsTab(),
      _createNotesTab(),
      _createAssetsTab(),
      _createEmergencyTab(),
      _createCovid19Tab(),
      _createOnboardingTab(),
      _createOffboardingTab(),
    ];
  }

  static TabModel _createProfileTab() {
    return TabModel(
      tabName: 'Profile',
      sections: [
        Section(
          sectionName: 'Basic Information',
          sectionType: 'form',
          fields: [
            Field(
                fieldName: 'Employee #',
                fieldKey: 'employee_number',
                fieldType: 'text',
                isRequired: true),
            Field(
                fieldName: 'Status',
                fieldKey: 'status',
                fieldType: 'select',
                isRequired: true,
                options: ['Active', 'Inactive', 'On Leave']),
            Field(
                fieldName: 'First Name',
                fieldKey: 'first_name',
                fieldType: 'text',
                isRequired: true),
            Field(
                fieldName: 'Middle Name',
                fieldKey: 'middle_name',
                fieldType: 'text'),
            Field(
                fieldName: 'Last Name',
                fieldKey: 'last_name',
                fieldType: 'text',
                isRequired: true),
            Field(
                fieldName: 'Preferred Name',
                fieldKey: 'preferred_name',
                fieldType: 'text'),
            Field(
                fieldName: 'Birth Date',
                fieldKey: 'birth_date',
                fieldType: 'date',
                isRequired: true),
            Field(
                fieldName: 'Age',
                fieldKey: 'age',
                fieldType: 'number',
                isEditable: false),
            Field(
                fieldName: 'Gender',
                fieldKey: 'gender',
                fieldType: 'select',
                isRequired: true,
                options: ['Male', 'Female', 'Other']),
            Field(
                fieldName: 'Marital Status',
                fieldKey: 'marital_status',
                fieldType: 'select',
                options: ['Single', 'Married', 'Divorced', 'Widowed']),
            Field(fieldName: 'SSN', fieldKey: 'ssn', fieldType: 'text'),
            Field(
                fieldName: 'Tax File Number',
                fieldKey: 'tax_file_number',
                fieldType: 'text'),
            Field(fieldName: 'NIN', fieldKey: 'nin', fieldType: 'text'),
            Field(
                fieldName: 'Shirt Size',
                fieldKey: 'shirt_size',
                fieldType: 'select',
                options: ['XS', 'S', 'M', 'L', 'XL', 'XXL']),
            Field(
                fieldName: 'Allergies',
                fieldKey: 'allergies',
                fieldType: 'text'),
            Field(
                fieldName: 'Dietary Restrictions',
                fieldKey: 'dietary_restrictions',
                fieldType: 'select',
                options: [
                  'None',
                  'Vegetarian',
                  'Vegan',
                  'Gluten-Free',
                  'Other'
                ]),
          ],
        ),
        Section(
          sectionName: 'Address',
          sectionType: 'form',
          fields: [
            Field(
                fieldName: 'Street',
                fieldKey: 'street',
                fieldType: 'text',
                isRequired: true),
            Field(
                fieldName: 'City',
                fieldKey: 'city',
                fieldType: 'text',
                isRequired: true),
            Field(
                fieldName: 'State/Province',
                fieldKey: 'state',
                fieldType: 'text',
                isRequired: true),
            Field(
                fieldName: 'ZIP/Postal Code',
                fieldKey: 'zip_code',
                fieldType: 'text',
                isRequired: true),
            Field(
                fieldName: 'Country',
                fieldKey: 'country',
                fieldType: 'select',
                isRequired: true,
                options: ['USA', 'Canada', 'UK', 'Australia']),
          ],
        ),
        Section(
          sectionName: 'Contact',
          sectionType: 'form',
          fields: [
            Field(
                fieldName: 'Email',
                fieldKey: 'email',
                fieldType: 'email',
                isRequired: true),
            Field(
                fieldName: 'Phone',
                fieldKey: 'phone',
                fieldType: 'tel',
                isRequired: true),
            Field(
                fieldName: 'Office Phone',
                fieldKey: 'office_phone',
                fieldType: 'tel'),
            Field(
                fieldName: 'Emergency Contact Name',
                fieldKey: 'emergency_contact_name',
                fieldType: 'text',
                isRequired: true),
            Field(
                fieldName: 'Emergency Contact Phone',
                fieldKey: 'emergency_contact_phone',
                fieldType: 'tel',
                isRequired: true),
          ],
        ),
        Section(
          subSections: [],
          sectionName: 'Social',
          sectionType: 'form',
          fields: [
            Field(
                fieldName: 'LinkedIn', fieldKey: 'linkedin', fieldType: 'url'),
            Field(
                fieldName: 'Facebook', fieldKey: 'facebook', fieldType: 'url'),
            Field(fieldName: 'Twitter', fieldKey: 'twitter', fieldType: 'url'),
            Field(
                fieldName: 'Instagram',
                fieldKey: 'instagram',
                fieldType: 'url'),
          ],
        ),
        Section(sectionName: 'Education', sectionType: 'form', subSections: [
          SubSection(
            name: "",
            isRepeatable: true,
            buttonNameToRepeat: "Add Education",
            fields: [
              Field(
                  fieldName: 'College/Institution',
                  fieldKey: 'institution',
                  fieldType: 'text',
                  isRequired: true),
              Field(
                  fieldName: 'Major/Specialization',
                  fieldKey: 'major',
                  fieldType: 'text',
                  isRequired: true),
              Field(
                  fieldName: 'Degree',
                  fieldKey: 'degree',
                  fieldType: 'select',
                  isRequired: true,
                  options: [
                    'High School',
                    'Associate',
                    'Bachelor\'s',
                    'Master\'s',
                    'PhD'
                  ]),
              Field(fieldName: 'GPA', fieldKey: 'gpa', fieldType: 'number'),
              Field(
                  fieldName: 'Start Date',
                  fieldKey: 'start_date',
                  fieldType: 'date',
                  isRequired: true),
              Field(
                  fieldName: 'End Date',
                  fieldKey: 'end_date',
                  fieldType: 'date'),
            ],
          ),
        ], fields: [
          Field(
              fieldName: 'Currently Studying',
              fieldKey: 'currently_studying',
              fieldType: 'checkbox'),
        ]),
        Section(
          sectionName: 'Visa',
          sectionType: 'table',
          table: TableModel(feildEntryButton: "Add Visa", columns: [
            TableColumn(name: 'Date', columnKey: 'date', dataType: 'date'),
            TableColumn(name: 'Visa', columnKey: 'visa_type', dataType: 'text'),
            TableColumn(
                name: 'Issuing Country',
                columnKey: 'issuing_country',
                dataType: 'text'),
            TableColumn(
                name: 'Issued', columnKey: 'issued_date', dataType: 'date'),
            TableColumn(
                name: 'Expiration',
                columnKey: 'expiration_date',
                dataType: 'date'),
            TableColumn(name: 'Status', columnKey: 'status', dataType: 'text'),
            TableColumn(name: 'Note', columnKey: 'note', dataType: 'text'),
            TableColumn(
                name: 'Actions', columnKey: 'actions', dataType: 'text'),
          ], rows: []),
          items: [],
          fields: [],
        ),
      ],
      isLocked: true,
      order: 0,
      visibility: Rx(TabVisibility.visible),
    );
  }

  static TabModel _createJobTab() {
    return TabModel(
      tabName: 'Job',
      sections: [
        Section(
          sectionName: 'Employment',
          sectionType: 'mixed',
          fields: [
            Field(
                fieldName: 'Veteran Status',
                fieldKey: 'veteran_status',
                fieldType: 'multiselect',
                options: [
                  'Active Duty Wartime or Campaign Badge Veteran',
                  'Armed Forces Service Medal Veteran',
                  'Disabled Veteran',
                  'Recently Separated Veteran'
                ]),
          ],
          items: [
            'Maja Andev',
            'Eric Atzure',
            'Cheryl Barnet',
            'Jake Bryan',
            'Jennifer Caldwell',
            'Dorothy Chou',
            'Ryota Saito',
            'Jeremy Steel',
            'Daniel Vance',
            'Trent Walsh'
          ],
        ),
        Section(
          sectionName: 'Employment Status',
          sectionType: 'table',
          table: TableModel(
            feildEntryButton: 'Add Employment Status',
            columns: [
              TableColumn(
                  name: 'Effective Date',
                  columnKey: 'effective_date',
                  dataType: 'date'),
              TableColumn(
                  name: 'Status', columnKey: 'status', dataType: 'text'),
              TableColumn(
                  name: 'Comment', columnKey: 'comment', dataType: 'text'),
              TableColumn(
                  name: 'Actions', columnKey: 'actions', dataType: 'text'),
            ],
            rows: [],
          ),
        ),
        Section(
          sectionName: 'Job Information',
          sectionType: 'table',
          table: TableModel(
            feildEntryButton: 'Add Job Info',
            columns: [
              TableColumn(
                  name: 'Effective Date',
                  columnKey: 'effective_date',
                  dataType: 'date'),
              TableColumn(
                  name: 'Location', columnKey: 'location', dataType: 'text'),
              TableColumn(
                  name: 'Division', columnKey: 'division', dataType: 'text'),
              TableColumn(
                  name: 'Department',
                  columnKey: 'department',
                  dataType: 'text'),
              TableColumn(name: 'Teams', columnKey: 'teams', dataType: 'text'),
              TableColumn(
                  name: 'Job Title', columnKey: 'job_title', dataType: 'text'),
              TableColumn(
                  name: 'Reports To',
                  columnKey: 'reports_to',
                  dataType: 'text'),
              TableColumn(
                  name: 'Actions', columnKey: 'actions', dataType: 'text'),
            ],
            rows: [],
          ),
        ),
        Section(
          sectionName: 'Compensation',
          sectionType: 'table',
          table: TableModel(
            feildEntryButton: 'Add Compensation',
            columns: [
              TableColumn(
                  name: 'Effective Date',
                  columnKey: 'effective_date',
                  dataType: 'date'),
              TableColumn(
                  name: 'Schedule', columnKey: 'schedule', dataType: 'text'),
              TableColumn(name: 'Type', columnKey: 'type', dataType: 'text'),
              TableColumn(name: 'Rate', columnKey: 'rate', dataType: 'number'),
              TableColumn(name: 'OT', columnKey: 'overtime', dataType: 'text'),
              TableColumn(
                  name: 'Reason', columnKey: 'reason', dataType: 'text'),
              TableColumn(
                  name: 'Comment', columnKey: 'comment', dataType: 'text'),
              TableColumn(
                  name: 'Actions', columnKey: 'actions', dataType: 'text'),
            ],
            rows: [],
          ),
        ),
        Section(
          sectionName: 'Potential Bonus',
          sectionType: 'form',
          fields: [
            Field(
                fieldName: 'Annual Percentage',
                fieldKey: 'annual_percentage',
                fieldType: 'number'),
            Field(
                fieldName: 'Annual Amount',
                fieldKey: 'annual_amount',
                fieldType: 'number',
                isEditable: false),
          ],
        ),
        Section(
          sectionName: 'Bonus',
          sectionType: 'table',
          table: TableModel(
            feildEntryButton: 'Add Bonus',
            columns: [
              TableColumn(
                  name: 'Amount', columnKey: 'amount', dataType: 'number'),
              TableColumn(
                  name: 'Reason', columnKey: 'reason', dataType: 'text'),
              TableColumn(
                  name: 'Comment', columnKey: 'comment', dataType: 'text'),
              TableColumn(
                  name: 'Actions', columnKey: 'actions', dataType: 'text'),
            ],
            rows: [],
          ),
        ),
        Section(
          sectionName: 'Commission',
          sectionType: 'table',
          table: TableModel(
            feildEntryButton: 'Add Commission',
            columns: [
              TableColumn(
                  name: 'Amount', columnKey: 'amount', dataType: 'number'),
              TableColumn(
                  name: 'Comment', columnKey: 'comment', dataType: 'text'),
              TableColumn(
                  name: 'Actions', columnKey: 'actions', dataType: 'text'),
            ],
            rows: [],
          ),
        ),
        Section(
          sectionName: 'Equity',
          sectionType: 'table',
          table: TableModel(
            feildEntryButton: 'Add Equity',
            columns: [
              TableColumn(name: 'Type', columnKey: 'type', dataType: 'text'),
              TableColumn(
                  name: 'Custom Type',
                  columnKey: 'custom_type',
                  dataType: 'text'),
              TableColumn(
                  name: 'Grant Date',
                  columnKey: 'grant_date',
                  dataType: 'date'),
              TableColumn(
                  name: 'Vesting Start',
                  columnKey: 'vesting_start',
                  dataType: 'date'),
              TableColumn(
                  name: 'Granted', columnKey: 'granted', dataType: 'number'),
              TableColumn(
                  name: 'Strike', columnKey: 'strike', dataType: 'number'),
              TableColumn(
                  name: 'Schedule', columnKey: 'schedule', dataType: 'text'),
              TableColumn(
                  name: 'Months', columnKey: 'months', dataType: 'number'),
              TableColumn(
                  name: 'Cliff', columnKey: 'cliff', dataType: 'number'),
              TableColumn(
                  name: 'Actions', columnKey: 'actions', dataType: 'text'),
            ],
            rows: [],
          ),
        ),
      ],
      isLocked: true,
      order: 1,
      visibility: Rx(TabVisibility.visible),
    );
  }

  static TabModel _createTrainingTab() {
    return TabModel(
      tabName: 'Training',
      sections: [
        Section(
          sectionName: 'Upcoming Training',
          sectionType: 'list',
          items: [
            TrainingItem(
              trainingName: 'Unlawful Harassment',
              dueDate: DateTime(2025, 12, 2),
              category: 'Required',
            ),
            TrainingItem(
              trainingName: 'BambooHR Advantage Package Demo Video',
              category: 'BambooHR Product Training',
            ),
            TrainingItem(
              trainingName: 'Quarterly Security Training',
              dueDate: DateTime(2025, 11, 18),
              category: 'Quarterly Training',
            ),
            TrainingItem(
              trainingName: 'Sexual Harassment Training',
              dueDate: DateTime(2022, 11, 10),
              isOverdue: true,
              category: 'Required Annual Trainings',
            ),
            TrainingItem(
              trainingName: 'Annual Security Training',
              category: 'Required Annual Trainings',
            ),
            TrainingItem(
              trainingName: 'HIPAA Training',
              category: 'Required Annual Trainings',
            ),
            TrainingItem(
              trainingName: 'OSHA Training',
              dueDate: DateTime(2022, 10, 14),
              isOverdue: true,
              category: 'Required Annual Trainings',
            ),
          ],
          fields: [],
        ),
        Section(
          sectionName: 'Completed Training',
          sectionType: 'table',
          table: TableModel(
            feildEntryButton: 'Add Training',
            columns: [
              TableColumn(
                  name: 'Training Name', columnKey: 'name', dataType: 'text'),
              TableColumn(
                  name: 'Completed', columnKey: 'completed', dataType: 'date'),
              TableColumn(name: 'Cost', columnKey: 'cost', dataType: 'number'),
              TableColumn(
                  name: 'Credits', columnKey: 'credits', dataType: 'number'),
              TableColumn(
                  name: 'Hours', columnKey: 'hours', dataType: 'number'),
              TableColumn(
                  name: 'Instructor',
                  columnKey: 'instructor',
                  dataType: 'text'),
              TableColumn(
                  name: 'Actions', columnKey: 'actions', dataType: 'text'),
            ],
            rows: [],
          ),
        ),
        Section(
          sectionName: 'Document Date',
          sectionType: 'form',
          fields: [
            Field(
                fieldName: 'Document Date',
                fieldKey: 'document_date',
                fieldType: 'date'),
          ],
        ),
      ],
      isLocked: true,
      order: 2,
      visibility: Rx(TabVisibility.visible),
    );
  }

  static TabModel _createTimeOffTab() {
    return TabModel(
      visibility: Rx(TabVisibility.visible),
      tabName: 'Time Off',
      sections: [],
      allowCustomFields: true,
      allowCustomTables: true,
      order: 3,
    );
  }

  static TabModel _createDocumentsTab() {
    return TabModel(
      visibility: Rx(TabVisibility.visible),
      tabName: 'Documents',
      sections: [
        Section(
          sectionName: 'Document Folders',
          sectionType: 'list',
          items: [
            DocumentItem(
                documentName: 'Employee Uploads',
                documentType: 'folder',
                itemCount: 2,
                uploadDate: DateTime(2025),
                filePath: ''),
            DocumentItem(
                documentName: 'Resumes and Applications',
                documentType: 'folder',
                itemCount: 0,
                uploadDate: DateTime(2025),
                filePath: ''),
            DocumentItem(
                documentName: 'Signed Documents',
                documentType: 'folder',
                itemCount: 1,
                uploadDate: DateTime(2025),
                filePath: ''),
            DocumentItem(
                documentName: 'Tasklist Attachments',
                documentType: 'folder',
                itemCount: 0,
                uploadDate: DateTime(2025),
                filePath: ''),
            DocumentItem(
                documentName: 'Workflow Attachments',
                documentType: 'folder',
                itemCount: 1,
                uploadDate: DateTime(2025),
                filePath: ''),
          ],
          fields: [],
        ),
      ],
      isLocked: true,
      order: 4,
    );
  }

  static TabModel _createBenefitsTab() {
    return TabModel(
      tabName: 'Benefits',
      sections: [
        Section(
          sectionName: 'Benefits Overview',
          sectionType: 'list',
          items: [
            BenefitItem(
                benefitType: 'Medical',
                planName: 'HDHP 1 Plan',
                eligibilityStatus: 'Eligible',
                isEligible: true),
            BenefitItem(
                benefitType: 'Medical',
                planName: 'HDHP 2 2025',
                eligibilityStatus: 'Eligible',
                isEligible: true),
            BenefitItem(
                benefitType: 'Medical',
                planName: 'FSA-Eligible HMO 2025',
                eligibilityStatus: 'Eligible',
                isEligible: true),
            BenefitItem(
                benefitType: 'Dental',
                planName: 'Dental Basic 2025',
                eligibilityStatus: 'Eligible',
                isEligible: true),
            BenefitItem(
                benefitType: 'Dental',
                planName: 'Dental Plus 2025',
                eligibilityStatus: 'Eligible',
                isEligible: true),
            BenefitItem(
                benefitType: 'Vision',
                planName: 'Vision Insurance 2025',
                eligibilityStatus: 'Eligible',
                isEligible: true),
            BenefitItem(
                benefitType: 'Retirement',
                planName: '401(k) Plan 2025',
                eligibilityStatus: 'Eligible',
                isEligible: true),
            BenefitItem(
                benefitType: 'HSA',
                planName: 'HSA',
                eligibilityStatus: 'Eligible',
                isEligible: true),
          ],
          fields: [],
        ),
        Section(
          sectionName: 'Supplemental',
          sectionType: 'list',
          items: [
            BenefitItem(
                benefitType: 'Accident',
                planName: 'Accident',
                eligibilityStatus: 'Eligible',
                isEligible: true),
            BenefitItem(
                benefitType: 'Critical Illness',
                planName: 'Critical Illness',
                eligibilityStatus: 'Eligible',
                isEligible: true),
            BenefitItem(
                benefitType: 'Hospital Indemnity',
                planName: 'Hospital Indemnity 2025',
                eligibilityStatus: 'Eligible',
                isEligible: true),
            BenefitItem(
                benefitType: 'UTC',
                planName: 'UTC - Critical Illness',
                eligibilityStatus: 'Eligible',
                isEligible: true),
          ],
          fields: [],
        ),
        Section(
          sectionName: 'Dependents',
          sectionType: 'table',
          table: TableModel(
            feildEntryButton: 'Add Dependent',
            columns: [
              TableColumn(name: 'Name', columnKey: 'name', dataType: 'text'),
              TableColumn(
                  name: 'Relationship',
                  columnKey: 'relationship',
                  dataType: 'text'),
              TableColumn(
                  name: 'Gender', columnKey: 'gender', dataType: 'text'),
              TableColumn(name: 'SSN', columnKey: 'ssn', dataType: 'text'),
              TableColumn(
                  name: 'Birth Date',
                  columnKey: 'birth_date',
                  dataType: 'date'),
              TableColumn(name: 'Note', columnKey: 'note', dataType: 'text'),
              TableColumn(
                  name: 'Actions', columnKey: 'actions', dataType: 'text'),
            ],
            rows: [],
          ),
        ),
        Section(
          sectionName: 'Benefit History',
          sectionType: 'table',
          table: TableModel(
            feildEntryButton: 'Add Benefit Event',
            columns: [
              TableColumn(
                  name: 'Date/Time',
                  columnKey: 'date_time',
                  dataType: 'datetime'),
              TableColumn(name: 'Event', columnKey: 'event', dataType: 'text'),
              TableColumn(name: 'Plan', columnKey: 'plan', dataType: 'text'),
              TableColumn(
                  name: 'Changed By',
                  columnKey: 'changed_by',
                  dataType: 'text'),
            ],
            rows: [],
          ),
        ),
      ],
      isLocked: true,
      order: 5,
      visibility: Rx(TabVisibility.visible),
    );
  }

  // ... Similar implementations for Notes, Assets, Emergency, COVID-19, Onboarding, Offboarding tabs ...

  static TabModel _createNotesTab() {
    return TabModel(
      tabName: 'Notes',
      sections: [
        Section(
          sectionName: 'Notes',
          sectionType: 'notes',
          items: [
            NoteItem(
                author: 'ABC XYZ',
                content: 'hello',
                timestamp: DateTime.now().subtract(const Duration(hours: 4))),
          ],
          fields: [],
        ),
      ],
      isLocked: true,
      order: 6,
      visibility: Rx(TabVisibility.visible),
    );
  }

  static TabModel _createAssetsTab() {
    return TabModel(
      tabName: 'Assets',
      sections: [
        Section(
          sectionName: 'Assets',
          sectionType: 'table',
          table: TableModel(
            feildEntryButton: 'Add Asset',
            columns: [
              TableColumn(
                  name: 'Asset Category',
                  columnKey: 'category',
                  dataType: 'text'),
              TableColumn(
                  name: 'Asset Description',
                  columnKey: 'description',
                  dataType: 'text'),
              TableColumn(
                  name: 'Serial Number',
                  columnKey: 'serial_number',
                  dataType: 'text'),
              TableColumn(
                  name: 'Assigned Date',
                  columnKey: 'assigned_date',
                  dataType: 'date'),
              TableColumn(
                  name: 'Return Date',
                  columnKey: 'return_date',
                  dataType: 'date'),
              TableColumn(
                  name: 'Status', columnKey: 'status', dataType: 'text'),
              TableColumn(
                  name: 'Actions', columnKey: 'actions', dataType: 'text'),
            ],
            rows: [],
          ),
        ),
      ],
      isLocked: true,
      order: 7,
      visibility: Rx(TabVisibility.visible),
    );
  }

  static TabModel _createEmergencyTab() {
    return TabModel(
      tabName: 'Emergency',
      sections: [
        Section(
          sectionName: 'Emergency Contacts',
          sectionType: 'form',
          subSections: [
            SubSection(
                name: "",
                buttonNameToRepeat: "Add Emergency Contact",
                isRepeatable: true,
                fields: [
                  Field(
                      fieldName: 'Contact Name',
                      fieldKey: 'contact_name',
                      fieldType: 'text',
                      isRequired: true),
                  Field(
                      fieldName: 'Relationship',
                      fieldKey: 'relationship',
                      fieldType: 'text',
                      isRequired: true),
                  Field(
                      fieldName: 'Mobile Phone',
                      fieldKey: 'mobile_phone',
                      fieldType: 'tel',
                      isRequired: true),
                  Field(
                      fieldName: 'Work Phone',
                      fieldKey: 'work_phone',
                      fieldType: 'tel'),
                  Field(
                      fieldName: 'Home Phone',
                      fieldKey: 'home_phone',
                      fieldType: 'tel'),
                  Field(
                      fieldName: 'Email',
                      fieldKey: 'email',
                      fieldType: 'email',
                      isRequired: true),
                  Field(
                      fieldName: 'Street Address',
                      fieldKey: 'street_address',
                      fieldType: 'text',
                      isRequired: true),
                  Field(
                      fieldName: 'City',
                      fieldKey: 'city',
                      fieldType: 'text',
                      isRequired: true),
                  Field(
                      fieldName: 'State/Province',
                      fieldKey: 'state',
                      fieldType: 'text',
                      isRequired: true),
                  Field(
                      fieldName: 'ZIP/Postal Code',
                      fieldKey: 'zip_code',
                      fieldType: 'text',
                      isRequired: true),
                  Field(
                      fieldName: 'Country',
                      fieldKey: 'country',
                      fieldType: 'select',
                      isRequired: true),
                ])
          ],
          fields: [],
        ),
      ],
      order: 8,
      visibility: Rx(TabVisibility.visible),
    );
  }

  static TabModel _createCovid19Tab() {
    return TabModel(
      tabName: 'COVID-19',
      sections: [
        Section(
          sectionName: 'COVID-19 Information',
          sectionType: 'form',
          fields: [
            Field(
                fieldName: 'Vaccination Status',
                fieldKey: 'vaccination_status',
                fieldType: 'select',
                options: [
                  'Not Vaccinated',
                  'Partially Vaccinated',
                  'Fully Vaccinated',
                  'Boosted'
                ]),
            Field(
                fieldName: 'First Dose Date',
                fieldKey: 'first_dose_date',
                fieldType: 'date'),
            Field(
                fieldName: 'Second Dose Date',
                fieldKey: 'second_dose_date',
                fieldType: 'date'),
            Field(
                fieldName: 'Booster Date',
                fieldKey: 'booster_date',
                fieldType: 'date'),
            Field(
                fieldName: 'Last Test Date',
                fieldKey: 'last_test_date',
                fieldType: 'date'),
            Field(
                fieldName: 'Test Result',
                fieldKey: 'test_result',
                fieldType: 'select',
                options: ['Negative', 'Positive', 'Pending']),
          ],
        ),
      ],
      order: 9,
      visibility: Rx(TabVisibility.visible),
    );
  }

  static TabModel _createOnboardingTab() {
    return TabModel(
      tabName: 'Onboarding',
      sections: [],
      allowCustomFields: true,
      allowCustomTables: true,
      order: 10,
      visibility: Rx(TabVisibility.visible),
    );
  }

  static TabModel _createOffboardingTab() {
    return TabModel(
      tabName: 'Offboarding',
      sections: [],
      allowCustomFields: true,
      allowCustomTables: true,
      order: 11,
      visibility: Rx(TabVisibility.visible),
    );
  }
}
