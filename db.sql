PGDMP                      }         	   employees    16.2    16.2 -               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    99346 	   employees    DATABASE     }   CREATE DATABASE employees WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE employees;
                postgres    false                       0    0    DATABASE employees    COMMENT     j   COMMENT ON DATABASE employees IS 'Кадровый учет сотудников организации';
                   postgres    false    4893            �            1255    115824 <   fio(character varying, character varying, character varying)    FUNCTION     �   CREATE FUNCTION public.fio(surname character varying, name character varying, patronymic character varying) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN CONCAT_WS(' ', surname, name, patronymic);
END;
$$;
 k   DROP FUNCTION public.fio(surname character varying, name character varying, patronymic character varying);
       public          postgres    false            �            1255    115823    full_name() 	   PROCEDURE     �   CREATE PROCEDURE public.full_name()
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE employees
    SET full_name = CONCAT(last_name, ' ', first_name, ' ', COALESCE(middle_name, ''));
END;
$$;
 #   DROP PROCEDURE public.full_name();
       public          postgres    false            �            1259    115738 	   addresses    TABLE     �   CREATE TABLE public.addresses (
    id integer NOT NULL,
    city character varying(255) NOT NULL,
    street character varying(255) NOT NULL,
    house_number character varying(5) NOT NULL,
    apartment integer
);
    DROP TABLE public.addresses;
       public         heap    postgres    false            �            1259    115737    addresses_id_seq    SEQUENCE     �   CREATE SEQUENCE public.addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.addresses_id_seq;
       public          postgres    false    218                       0    0    addresses_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;
          public          postgres    false    217            �            1259    115784    contacts    TABLE     �  CREATE TABLE public.contacts (
    id integer NOT NULL,
    phone_number character varying(16),
    email character varying(100),
    telegram character varying(100),
    CONSTRAINT contacts_email_check CHECK (((email)::text ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'::text)),
    CONSTRAINT contacts_phone_number_check CHECK (((phone_number)::text ~ '^\+7\(\d{3}\)\d{3}-\d{2}-\d{2}$'::text)),
    CONSTRAINT contacts_telegram_check CHECK (((telegram)::text ~ '^@[A-Za-z0-9_]{5,}$'::text))
);
    DROP TABLE public.contacts;
       public         heap    postgres    false            �            1259    115783    contacts_id_seq    SEQUENCE     �   CREATE SEQUENCE public.contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.contacts_id_seq;
       public          postgres    false    222                        0    0    contacts_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.contacts_id_seq OWNED BY public.contacts.id;
          public          postgres    false    221            �            1259    115731    departments    TABLE     g   CREATE TABLE public.departments (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);
    DROP TABLE public.departments;
       public         heap    postgres    false            �            1259    115730    departments_id_seq    SEQUENCE     �   CREATE SEQUENCE public.departments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.departments_id_seq;
       public          postgres    false    216            !           0    0    departments_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.departments_id_seq OWNED BY public.departments.id;
          public          postgres    false    215            �            1259    115794 	   employees    TABLE     �  CREATE TABLE public.employees (
    id integer NOT NULL,
    last_name character varying(255) NOT NULL,
    first_name character varying(255) NOT NULL,
    middle_name character varying(255),
    passport_number character(11) NOT NULL,
    address_id integer NOT NULL,
    department_id integer NOT NULL,
    position_id integer NOT NULL,
    salary integer NOT NULL,
    hire_date date NOT NULL,
    is_employed boolean NOT NULL,
    phone_number character varying(20) NOT NULL,
    email character varying(255),
    telegram character varying(255),
    birthday date NOT NULL,
    CONSTRAINT employees_email_check CHECK (((email)::text ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'::text)),
    CONSTRAINT employees_passport_number_check CHECK ((passport_number ~ '^\d{4} \d{6}$'::text)),
    CONSTRAINT employees_phone_number_check CHECK (((phone_number)::text ~* '^\+7\(\d{3}\)\d{3}-\d{2}-\d{2}$'::text)),
    CONSTRAINT employees_telegram_check CHECK (((telegram)::text ~* '^@[a-zA-Z0-9_]{5,32}$'::text))
);
    DROP TABLE public.employees;
       public         heap    postgres    false            �            1259    115793    employees_id_seq    SEQUENCE     �   CREATE SEQUENCE public.employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.employees_id_seq;
       public          postgres    false    224            "           0    0    employees_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;
          public          postgres    false    223            �            1259    115747 	   positions    TABLE     e   CREATE TABLE public.positions (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);
    DROP TABLE public.positions;
       public         heap    postgres    false            �            1259    115746    positions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.positions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.positions_id_seq;
       public          postgres    false    220            #           0    0    positions_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.positions_id_seq OWNED BY public.positions.id;
          public          postgres    false    219            g           2604    115741    addresses id    DEFAULT     l   ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);
 ;   ALTER TABLE public.addresses ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    218    218            i           2604    115787    contacts id    DEFAULT     j   ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);
 :   ALTER TABLE public.contacts ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    222    222            f           2604    115734    departments id    DEFAULT     p   ALTER TABLE ONLY public.departments ALTER COLUMN id SET DEFAULT nextval('public.departments_id_seq'::regclass);
 =   ALTER TABLE public.departments ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            j           2604    115797    employees id    DEFAULT     l   ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);
 ;   ALTER TABLE public.employees ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223    224            h           2604    115750    positions id    DEFAULT     l   ALTER TABLE ONLY public.positions ALTER COLUMN id SET DEFAULT nextval('public.positions_id_seq'::regclass);
 ;   ALTER TABLE public.positions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219    220                      0    115738 	   addresses 
   TABLE DATA           N   COPY public.addresses (id, city, street, house_number, apartment) FROM stdin;
    public          postgres    false    218   7                 0    115784    contacts 
   TABLE DATA           E   COPY public.contacts (id, phone_number, email, telegram) FROM stdin;
    public          postgres    false    222   �7                 0    115731    departments 
   TABLE DATA           /   COPY public.departments (id, name) FROM stdin;
    public          postgres    false    216   48                 0    115794 	   employees 
   TABLE DATA           �   COPY public.employees (id, last_name, first_name, middle_name, passport_number, address_id, department_id, position_id, salary, hire_date, is_employed, phone_number, email, telegram, birthday) FROM stdin;
    public          postgres    false    224   �8                 0    115747 	   positions 
   TABLE DATA           -   COPY public.positions (id, name) FROM stdin;
    public          postgres    false    220   4;       $           0    0    addresses_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.addresses_id_seq', 12, true);
          public          postgres    false    217            %           0    0    contacts_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.contacts_id_seq', 1, false);
          public          postgres    false    221            &           0    0    departments_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.departments_id_seq', 1, true);
          public          postgres    false    215            '           0    0    employees_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.employees_id_seq', 36, true);
          public          postgres    false    223            (           0    0    positions_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.positions_id_seq', 1, true);
          public          postgres    false    219            u           2606    115745    addresses addresses_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.addresses DROP CONSTRAINT addresses_pkey;
       public            postgres    false    218            y           2606    115792    contacts contacts_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.contacts DROP CONSTRAINT contacts_pkey;
       public            postgres    false    222            s           2606    115736    departments departments_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.departments DROP CONSTRAINT departments_pkey;
       public            postgres    false    216            {           2606    115802    employees employees_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_pkey;
       public            postgres    false    224            w           2606    115752    positions positions_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.positions DROP CONSTRAINT positions_pkey;
       public            postgres    false    220            |           2606    115808 #   employees employees_address_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.addresses(id);
 M   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_address_id_fkey;
       public          postgres    false    224    218    4725            }           2606    115813 &   employees employees_department_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);
 P   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_department_id_fkey;
       public          postgres    false    224    216    4723            ~           2606    115818 $   employees employees_position_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_position_id_fkey FOREIGN KEY (position_id) REFERENCES public.positions(id);
 N   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_position_id_fkey;
       public          postgres    false    220    224    4727               �   x���K
1�ur���t\z =�� �
n}��A� "�����9Cr#�A\�E݅�kҤ����pJ�Q�7�������IgR�\
qr�Bs�#��W$KĎ��I�6��sSy��{q����&�l�Rs���U��c��!��"wy���[�ML�Y�G����[ESy_D����.U_]�]��ٷsj)�����]���oa%5         :   x�3��6װ40ִ�0�52�56�4426)--uH�M���K���t(,O-*������ -�         �   x�e���0�k�)� H�355Ð4P"!�� �$61	�獸!�h,��w����Pa�'<|�b�01�.����¡����#4M�p���F�j��}9&
WB���ь��:U8�i9�����z����a�p$S���S�hx�� �����d�	eh8�4�3w��CQ����YLV}y��         %  x����n�@���O�e#�h�<?;oy6Vm;���$����`�B��/ �4R��a�F�7���R&�̜oι7\��lΛw�������8ݹ�֮��yeWvgo�s���6oA%�X(mp@A��#�"�sx�N�=)HdH�8�z�V�i���U�������<��`?�[{�b���}qm׈��4�?ṟb�E�e,�J�����|D¼�#=�E�Q�A]d��t�R�E2��Ÿ:�@R�Y^͵?���Јɀ��t�V�޿�}(N���u�����P��V�2���PZ��<���r�L��.;[��^�=��׭3hDsa��a��Er�C��ƇFA�cCO>��B8�c�HL�A:���feԘ���`� ��6��>z�on��6��:@N=$~x ƘG��X�nQ����/�.]z[�CWH�0�w�k
µǈ�e~-��Nz�a\&b
�2��y�:��}<�������z��Pg9�������Fe=*�Q]f��@������?� ��D�u����\pǊ���Q`"x���'��         o   x�-���0D�x
&@�;Ä� %�(��8D
[�{g�6������V�Q-v�ďڂ�!\�R�+��`&���ɈS:"�����L�M�Gu|�Jy��S�     