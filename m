Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0C27E226F
	for <lists+linux-s390@lfdr.de>; Mon,  6 Nov 2023 13:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjKFMyT (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 6 Nov 2023 07:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjKFMyR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Nov 2023 07:54:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E000B8;
        Mon,  6 Nov 2023 04:54:11 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6B1hCk016957;
        Mon, 6 Nov 2023 12:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/AWNHsWHpQmo0ctNX43Tce+bb0Wuj2EF4IUvQcobGBU=;
 b=HNEi84XSaXW/YfRLGnuBvz5osHKQVF7DJOlTpn0IS3P0VYk0Goidbnl2dplTeHqQ2WVW
 vFOE0XcX7UopQc8OzvPDEa23NuJLncEeuvR5/VixcYYK9pQeXppJtHPvN1mSnM/447ST
 Y/8HW+5MmGELbnuT9sPyajwyGFgTLN3ziNdlhqiEhfzODM7kIzojs70Yh49PbD9shh3H
 xfFRvYWZhATVJavMoeF0o7v1/4BED3CwPcSTppyXO3WcTWR9f0KK1FNYoCaLUJD1nPnU
 ennUxP0Iczlw0oGigOyeZ2OqEf8+VAyq6pJYAM6LwSRH/NUeRDALD/aGG9NIrbYErVdc PA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6wrdnawe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:54:01 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6CKpQ2028766;
        Mon, 6 Nov 2023 12:54:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6wrdnavq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:54:01 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6Be7jT007926;
        Mon, 6 Nov 2023 12:54:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u61sk94gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:53:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6CrrNP30998960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 12:53:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0625720040;
        Mon,  6 Nov 2023 12:53:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2D412004B;
        Mon,  6 Nov 2023 12:53:52 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Nov 2023 12:53:52 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, thuth@redhat.com,
        david@redhat.com, pbonzini@redhat.com, andrew.jones@linux.dev,
        lvivier@redhat.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v1 01/10] make: add target to check kernel-doc comments
Date:   Mon,  6 Nov 2023 13:50:57 +0100
Message-ID: <20231106125352.859992-2-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106125352.859992-1-nrb@linux.ibm.com>
References: <20231106125352.859992-1-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q9DwFMb5z6sbe332co-e4ETBNk8Wb5Sk
X-Proofpoint-GUID: OfqHxeMS3hgCRWJQMy1Prh__L_6bZpBt
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_11,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

When we have a kernel-doc comment, it should be properly formatted.
Since this is a task that can be easily automated, add a new target
which checks all comments for proper kernel-doc formatting.

The kernel-doc script is copied as-is from the Linux kernel.

Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
---
 Makefile           |    3 +
 scripts/kernel-doc | 2526 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 2529 insertions(+)
 create mode 100755 scripts/kernel-doc

diff --git a/Makefile b/Makefile
index 101c02803228..602910dda11b 100644
--- a/Makefile
+++ b/Makefile
@@ -144,3 +144,6 @@ cscope:
 .PHONY: tags
 tags:
 	ctags -R
+
+check-kerneldoc:
+	find . -name '*.[ch]' -exec scripts/kernel-doc -none {} +
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
new file mode 100755
index 000000000000..6e199a745ccb
--- /dev/null
+++ b/scripts/kernel-doc
@@ -0,0 +1,2526 @@
+#!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-2.0
+
+use warnings;
+use strict;
+
+## Copyright (c) 1998 Michael Zucchi, All Rights Reserved        ##
+## Copyright (C) 2000, 1  Tim Waugh <twaugh@redhat.com>          ##
+## Copyright (C) 2001  Simon Huggins                             ##
+## Copyright (C) 2005-2012  Randy Dunlap                         ##
+## Copyright (C) 2012  Dan Luedtke                               ##
+## 								 ##
+## #define enhancements by Armin Kuster <akuster@mvista.com>	 ##
+## Copyright (c) 2000 MontaVista Software, Inc.			 ##
+#
+# Copyright (C) 2022 Tomasz Warniełło (POD)
+
+use Pod::Usage qw/pod2usage/;
+
+=head1 NAME
+
+kernel-doc - Print formatted kernel documentation to stdout
+
+=head1 SYNOPSIS
+
+ kernel-doc [-h] [-v] [-Werror] [-Wall] [-Wreturn] [-Wshort-description] [-Wcontents-before-sections]
+   [ -man |
+     -rst [-sphinx-version VERSION] [-enable-lineno] |
+     -none
+   ]
+   [
+     -export |
+     -internal |
+     [-function NAME] ... |
+     [-nosymbol NAME] ...
+   ]
+   [-no-doc-sections]
+   [-export-file FILE] ...
+   FILE ...
+
+Run `kernel-doc -h` for details.
+
+=head1 DESCRIPTION
+
+Read C language source or header FILEs, extract embedded documentation comments,
+and print formatted documentation to standard output.
+
+The documentation comments are identified by the "/**" opening comment mark.
+
+See Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
+
+=cut
+
+# more perldoc at the end of the file
+
+## init lots of data
+
+my $errors = 0;
+my $warnings = 0;
+my $anon_struct_union = 0;
+
+# match expressions used to find embedded type information
+my $type_constant = '\b``([^\`]+)``\b';
+my $type_constant2 = '\%([-_\w]+)';
+my $type_func = '(\w+)\(\)';
+my $type_param = '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
+my $type_param_ref = '([\!~]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
+my $type_fp_param = '\@(\w+)\(\)';  # Special RST handling for func ptr params
+my $type_fp_param2 = '\@(\w+->\S+)\(\)';  # Special RST handling for structs with func ptr params
+my $type_env = '(\$\w+)';
+my $type_enum = '\&(enum\s*([_\w]+))';
+my $type_struct = '\&(struct\s*([_\w]+))';
+my $type_typedef = '\&(typedef\s*([_\w]+))';
+my $type_union = '\&(union\s*([_\w]+))';
+my $type_member = '\&([_\w]+)(\.|->)([_\w]+)';
+my $type_fallback = '\&([_\w]+)';
+my $type_member_func = $type_member . '\(\)';
+
+# Output conversion substitutions.
+#  One for each output format
+
+# these are pretty rough
+my @highlights_man = (
+                      [$type_constant, "\$1"],
+                      [$type_constant2, "\$1"],
+                      [$type_func, "\\\\fB\$1\\\\fP"],
+                      [$type_enum, "\\\\fI\$1\\\\fP"],
+                      [$type_struct, "\\\\fI\$1\\\\fP"],
+                      [$type_typedef, "\\\\fI\$1\\\\fP"],
+                      [$type_union, "\\\\fI\$1\\\\fP"],
+                      [$type_param, "\\\\fI\$1\\\\fP"],
+                      [$type_param_ref, "\\\\fI\$1\$2\\\\fP"],
+                      [$type_member, "\\\\fI\$1\$2\$3\\\\fP"],
+                      [$type_fallback, "\\\\fI\$1\\\\fP"]
+		     );
+my $blankline_man = "";
+
+# rst-mode
+my @highlights_rst = (
+                       [$type_constant, "``\$1``"],
+                       [$type_constant2, "``\$1``"],
+                       # Note: need to escape () to avoid func matching later
+                       [$type_member_func, "\\:c\\:type\\:`\$1\$2\$3\\\\(\\\\) <\$1>`"],
+                       [$type_member, "\\:c\\:type\\:`\$1\$2\$3 <\$1>`"],
+		       [$type_fp_param, "**\$1\\\\(\\\\)**"],
+		       [$type_fp_param2, "**\$1\\\\(\\\\)**"],
+                       [$type_func, "\$1()"],
+                       [$type_enum, "\\:c\\:type\\:`\$1 <\$2>`"],
+                       [$type_struct, "\\:c\\:type\\:`\$1 <\$2>`"],
+                       [$type_typedef, "\\:c\\:type\\:`\$1 <\$2>`"],
+                       [$type_union, "\\:c\\:type\\:`\$1 <\$2>`"],
+                       # in rst this can refer to any type
+                       [$type_fallback, "\\:c\\:type\\:`\$1`"],
+                       [$type_param_ref, "**\$1\$2**"]
+		      );
+my $blankline_rst = "\n";
+
+# read arguments
+if ($#ARGV == -1) {
+	pod2usage(
+		-message => "No arguments!\n",
+		-exitval => 1,
+		-verbose => 99,
+		-sections => 'SYNOPSIS',
+		-output => \*STDERR,
+	);
+}
+
+my $kernelversion;
+my ($sphinx_major, $sphinx_minor, $sphinx_patch);
+
+my $dohighlight = "";
+
+my $verbose = 0;
+my $Werror = 0;
+my $Wreturn = 0;
+my $Wshort_desc = 0;
+my $Wcontents_before_sections = 0;
+my $output_mode = "rst";
+my $output_preformatted = 0;
+my $no_doc_sections = 0;
+my $enable_lineno = 0;
+my @highlights = @highlights_rst;
+my $blankline = $blankline_rst;
+my $modulename = "Kernel API";
+
+use constant {
+    OUTPUT_ALL          => 0, # output all symbols and doc sections
+    OUTPUT_INCLUDE      => 1, # output only specified symbols
+    OUTPUT_EXPORTED     => 2, # output exported symbols
+    OUTPUT_INTERNAL     => 3, # output non-exported symbols
+};
+my $output_selection = OUTPUT_ALL;
+my $show_not_found = 0;	# No longer used
+
+my @export_file_list;
+
+my @build_time;
+if (defined($ENV{'KBUILD_BUILD_TIMESTAMP'}) &&
+    (my $seconds = `date -d"${ENV{'KBUILD_BUILD_TIMESTAMP'}}" +%s`) ne '') {
+    @build_time = gmtime($seconds);
+} else {
+    @build_time = localtime;
+}
+
+my $man_date = ('January', 'February', 'March', 'April', 'May', 'June',
+		'July', 'August', 'September', 'October',
+		'November', 'December')[$build_time[4]] .
+  " " . ($build_time[5]+1900);
+
+# Essentially these are globals.
+# They probably want to be tidied up, made more localised or something.
+# CAVEAT EMPTOR!  Some of the others I localised may not want to be, which
+# could cause "use of undefined value" or other bugs.
+my ($function, %function_table, %parametertypes, $declaration_purpose);
+my %nosymbol_table = ();
+my $declaration_start_line;
+my ($type, $declaration_name, $return_type);
+my ($newsection, $newcontents, $prototype, $brcount, %source_map);
+
+if (defined($ENV{'KBUILD_VERBOSE'}) && $ENV{'KBUILD_VERBOSE'} =~ '1') {
+	$verbose = 1;
+}
+
+if (defined($ENV{'KCFLAGS'})) {
+	my $kcflags = "$ENV{'KCFLAGS'}";
+
+	if ($kcflags =~ /Werror/) {
+		$Werror = 1;
+	}
+}
+
+# reading this variable is for backwards compat just in case
+# someone was calling it with the variable from outside the
+# kernel's build system
+if (defined($ENV{'KDOC_WERROR'})) {
+	$Werror = "$ENV{'KDOC_WERROR'}";
+}
+# other environment variables are converted to command-line
+# arguments in cmd_checkdoc in the build system
+
+# Generated docbook code is inserted in a template at a point where
+# docbook v3.1 requires a non-zero sequence of RefEntry's; see:
+# https://www.oasis-open.org/docbook/documentation/reference/html/refentry.html
+# We keep track of number of generated entries and generate a dummy
+# if needs be to ensure the expanded template can be postprocessed
+# into html.
+my $section_counter = 0;
+
+my $lineprefix="";
+
+# Parser states
+use constant {
+    STATE_NORMAL        => 0,        # normal code
+    STATE_NAME          => 1,        # looking for function name
+    STATE_BODY_MAYBE    => 2,        # body - or maybe more description
+    STATE_BODY          => 3,        # the body of the comment
+    STATE_BODY_WITH_BLANK_LINE => 4, # the body, which has a blank line
+    STATE_PROTO         => 5,        # scanning prototype
+    STATE_DOCBLOCK      => 6,        # documentation block
+    STATE_INLINE        => 7,        # gathering doc outside main block
+};
+my $state;
+my $in_doc_sect;
+my $leading_space;
+
+# Inline documentation state
+use constant {
+    STATE_INLINE_NA     => 0, # not applicable ($state != STATE_INLINE)
+    STATE_INLINE_NAME   => 1, # looking for member name (@foo:)
+    STATE_INLINE_TEXT   => 2, # looking for member documentation
+    STATE_INLINE_END    => 3, # done
+    STATE_INLINE_ERROR  => 4, # error - Comment without header was found.
+                              # Spit a warning as it's not
+                              # proper kernel-doc and ignore the rest.
+};
+my $inline_doc_state;
+
+#declaration types: can be
+# 'function', 'struct', 'union', 'enum', 'typedef'
+my $decl_type;
+
+# Name of the kernel-doc identifier for non-DOC markups
+my $identifier;
+
+my $doc_start = '^/\*\*\s*$'; # Allow whitespace at end of comment start.
+my $doc_end = '\*/';
+my $doc_com = '\s*\*\s*';
+my $doc_com_body = '\s*\* ?';
+my $doc_decl = $doc_com . '(\w+)';
+# @params and a strictly limited set of supported section names
+# Specifically:
+#   Match @word:
+#	  @...:
+#         @{section-name}:
+# while trying to not match literal block starts like "example::"
+#
+my $doc_sect = $doc_com .
+    '\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:([^:].*)?$';
+my $doc_content = $doc_com_body . '(.*)';
+my $doc_block = $doc_com . 'DOC:\s*(.*)?';
+my $doc_inline_start = '^\s*/\*\*\s*$';
+my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';
+my $doc_inline_end = '^\s*\*/\s*$';
+my $doc_inline_oneline = '^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$';
+my $export_symbol = '^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*;';
+my $export_symbol_ns = '^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*\w+\)\s*;';
+my $function_pointer = qr{([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)};
+my $attribute = qr{__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)}i;
+
+my %parameterdescs;
+my %parameterdesc_start_lines;
+my @parameterlist;
+my %sections;
+my @sectionlist;
+my %section_start_lines;
+my $sectcheck;
+my $struct_actual;
+
+my $contents = "";
+my $new_start_line = 0;
+
+# the canonical section names. see also $doc_sect above.
+my $section_default = "Description";	# default section
+my $section_intro = "Introduction";
+my $section = $section_default;
+my $section_context = "Context";
+my $section_return = "Return";
+
+my $undescribed = "-- undescribed --";
+
+reset_state();
+
+while ($ARGV[0] =~ m/^--?(.*)/) {
+    my $cmd = $1;
+    shift @ARGV;
+    if ($cmd eq "man") {
+	$output_mode = "man";
+	@highlights = @highlights_man;
+	$blankline = $blankline_man;
+    } elsif ($cmd eq "rst") {
+	$output_mode = "rst";
+	@highlights = @highlights_rst;
+	$blankline = $blankline_rst;
+    } elsif ($cmd eq "none") {
+	$output_mode = "none";
+    } elsif ($cmd eq "module") { # not needed for XML, inherits from calling document
+	$modulename = shift @ARGV;
+    } elsif ($cmd eq "function") { # to only output specific functions
+	$output_selection = OUTPUT_INCLUDE;
+	$function = shift @ARGV;
+	$function_table{$function} = 1;
+    } elsif ($cmd eq "nosymbol") { # Exclude specific symbols
+	my $symbol = shift @ARGV;
+	$nosymbol_table{$symbol} = 1;
+    } elsif ($cmd eq "export") { # only exported symbols
+	$output_selection = OUTPUT_EXPORTED;
+	%function_table = ();
+    } elsif ($cmd eq "internal") { # only non-exported symbols
+	$output_selection = OUTPUT_INTERNAL;
+	%function_table = ();
+    } elsif ($cmd eq "export-file") {
+	my $file = shift @ARGV;
+	push(@export_file_list, $file);
+    } elsif ($cmd eq "v") {
+	$verbose = 1;
+    } elsif ($cmd eq "Werror") {
+	$Werror = 1;
+    } elsif ($cmd eq "Wreturn") {
+	$Wreturn = 1;
+    } elsif ($cmd eq "Wshort-desc") {
+	$Wshort_desc = 1;
+    } elsif ($cmd eq "Wcontents-before-sections") {
+	$Wcontents_before_sections = 1;
+    } elsif ($cmd eq "Wall") {
+        $Wreturn = 1;
+        $Wshort_desc = 1;
+        $Wcontents_before_sections = 1;
+    } elsif (($cmd eq "h") || ($cmd eq "help")) {
+		pod2usage(-exitval => 0, -verbose => 2);
+    } elsif ($cmd eq 'no-doc-sections') {
+	    $no_doc_sections = 1;
+    } elsif ($cmd eq 'enable-lineno') {
+	    $enable_lineno = 1;
+    } elsif ($cmd eq 'show-not-found') {
+	$show_not_found = 1;  # A no-op but don't fail
+    } elsif ($cmd eq "sphinx-version") {
+	my $ver_string = shift @ARGV;
+	if ($ver_string =~ m/^(\d+)(\.\d+)?(\.\d+)?/) {
+	    $sphinx_major = $1;
+	    if (defined($2)) {
+		$sphinx_minor = substr($2,1);
+	    } else {
+		$sphinx_minor = 0;
+	    }
+	    if (defined($3)) {
+		$sphinx_patch = substr($3,1)
+	    } else {
+		$sphinx_patch = 0;
+	    }
+	} else {
+	    die "Sphinx version should either major.minor or major.minor.patch format\n";
+	}
+    } else {
+	# Unknown argument
+	pod2usage(
+	    -message => "Argument unknown!\n",
+	    -exitval => 1,
+	    -verbose => 99,
+	    -sections => 'SYNOPSIS',
+	    -output => \*STDERR,
+	    );
+    }
+    if ($#ARGV < 0){
+	pod2usage(
+	    -message => "FILE argument missing\n",
+	    -exitval => 1,
+	    -verbose => 99,
+	    -sections => 'SYNOPSIS',
+	    -output => \*STDERR,
+	    );
+    }
+}
+
+# continue execution near EOF;
+
+# The C domain dialect changed on Sphinx 3. So, we need to check the
+# version in order to produce the right tags.
+sub findprog($)
+{
+	foreach(split(/:/, $ENV{PATH})) {
+		return "$_/$_[0]" if(-x "$_/$_[0]");
+	}
+}
+
+sub get_sphinx_version()
+{
+	my $ver;
+
+	my $cmd = "sphinx-build";
+	if (!findprog($cmd)) {
+		my $cmd = "sphinx-build3";
+		if (!findprog($cmd)) {
+			$sphinx_major = 1;
+			$sphinx_minor = 2;
+			$sphinx_patch = 0;
+			printf STDERR "Warning: Sphinx version not found. Using default (Sphinx version %d.%d.%d)\n",
+			       $sphinx_major, $sphinx_minor, $sphinx_patch;
+			return;
+		}
+	}
+
+	open IN, "$cmd --version 2>&1 |";
+	while (<IN>) {
+		if (m/^\s*sphinx-build\s+([\d]+)\.([\d\.]+)(\+\/[\da-f]+)?$/) {
+			$sphinx_major = $1;
+			$sphinx_minor = $2;
+			$sphinx_patch = $3;
+			last;
+		}
+		# Sphinx 1.2.x uses a different format
+		if (m/^\s*Sphinx.*\s+([\d]+)\.([\d\.]+)$/) {
+			$sphinx_major = $1;
+			$sphinx_minor = $2;
+			$sphinx_patch = $3;
+			last;
+		}
+	}
+	close IN;
+}
+
+# get kernel version from env
+sub get_kernel_version() {
+    my $version = 'unknown kernel version';
+
+    if (defined($ENV{'KERNELVERSION'})) {
+	$version = $ENV{'KERNELVERSION'};
+    }
+    return $version;
+}
+
+#
+sub print_lineno {
+    my $lineno = shift;
+    if ($enable_lineno && defined($lineno)) {
+        print ".. LINENO " . $lineno . "\n";
+    }
+}
+
+sub emit_warning {
+    my $location = shift;
+    my $msg = shift;
+    print STDERR "$location: warning: $msg";
+    ++$warnings;
+}
+##
+# dumps section contents to arrays/hashes intended for that purpose.
+#
+sub dump_section {
+    my $file = shift;
+    my $name = shift;
+    my $contents = join "\n", @_;
+
+    if ($name =~ m/$type_param/) {
+	$name = $1;
+	$parameterdescs{$name} = $contents;
+	$sectcheck = $sectcheck . $name . " ";
+        $parameterdesc_start_lines{$name} = $new_start_line;
+        $new_start_line = 0;
+    } elsif ($name eq "@\.\.\.") {
+	$name = "...";
+	$parameterdescs{$name} = $contents;
+	$sectcheck = $sectcheck . $name . " ";
+        $parameterdesc_start_lines{$name} = $new_start_line;
+        $new_start_line = 0;
+    } else {
+	if (defined($sections{$name}) && ($sections{$name} ne "")) {
+	    # Only warn on user specified duplicate section names.
+	    if ($name ne $section_default) {
+		emit_warning("${file}:$.", "duplicate section name '$name'\n");
+	    }
+	    $sections{$name} .= $contents;
+	} else {
+	    $sections{$name} = $contents;
+	    push @sectionlist, $name;
+            $section_start_lines{$name} = $new_start_line;
+            $new_start_line = 0;
+	}
+    }
+}
+
+##
+# dump DOC: section after checking that it should go out
+#
+sub dump_doc_section {
+    my $file = shift;
+    my $name = shift;
+    my $contents = join "\n", @_;
+
+    if ($no_doc_sections) {
+        return;
+    }
+
+    return if (defined($nosymbol_table{$name}));
+
+    if (($output_selection == OUTPUT_ALL) ||
+	(($output_selection == OUTPUT_INCLUDE) &&
+	 defined($function_table{$name})))
+    {
+	dump_section($file, $name, $contents);
+	output_blockhead({'sectionlist' => \@sectionlist,
+			  'sections' => \%sections,
+			  'module' => $modulename,
+			  'content-only' => ($output_selection != OUTPUT_ALL), });
+    }
+}
+
+##
+# output function
+#
+# parameterdescs, a hash.
+#  function => "function name"
+#  parameterlist => @list of parameters
+#  parameterdescs => %parameter descriptions
+#  sectionlist => @list of sections
+#  sections => %section descriptions
+#
+
+sub output_highlight {
+    my $contents = join "\n",@_;
+    my $line;
+
+#   DEBUG
+#   if (!defined $contents) {
+#	use Carp;
+#	confess "output_highlight got called with no args?\n";
+#   }
+
+#   print STDERR "contents b4:$contents\n";
+    eval $dohighlight;
+    die $@ if $@;
+#   print STDERR "contents af:$contents\n";
+
+    foreach $line (split "\n", $contents) {
+	if (! $output_preformatted) {
+	    $line =~ s/^\s*//;
+	}
+	if ($line eq ""){
+	    if (! $output_preformatted) {
+		print $lineprefix, $blankline;
+	    }
+	} else {
+	    if ($output_mode eq "man" && substr($line, 0, 1) eq ".") {
+		print "\\&$line";
+	    } else {
+		print $lineprefix, $line;
+	    }
+	}
+	print "\n";
+    }
+}
+
+##
+# output function in man
+sub output_function_man(%) {
+    my %args = %{$_[0]};
+    my ($parameter, $section);
+    my $count;
+
+    print ".TH \"$args{'function'}\" 9 \"$args{'function'}\" \"$man_date\" \"Kernel Hacker's Manual\" LINUX\n";
+
+    print ".SH NAME\n";
+    print $args{'function'} . " \\- " . $args{'purpose'} . "\n";
+
+    print ".SH SYNOPSIS\n";
+    if ($args{'functiontype'} ne "") {
+	print ".B \"" . $args{'functiontype'} . "\" " . $args{'function'} . "\n";
+    } else {
+	print ".B \"" . $args{'function'} . "\n";
+    }
+    $count = 0;
+    my $parenth = "(";
+    my $post = ",";
+    foreach my $parameter (@{$args{'parameterlist'}}) {
+	if ($count == $#{$args{'parameterlist'}}) {
+	    $post = ");";
+	}
+	$type = $args{'parametertypes'}{$parameter};
+	if ($type =~ m/$function_pointer/) {
+	    # pointer-to-function
+	    print ".BI \"" . $parenth . $1 . "\" " . " \") (" . $2 . ")" . $post . "\"\n";
+	} else {
+	    $type =~ s/([^\*])$/$1 /;
+	    print ".BI \"" . $parenth . $type . "\" " . " \"" . $post . "\"\n";
+	}
+	$count++;
+	$parenth = "";
+    }
+
+    print ".SH ARGUMENTS\n";
+    foreach $parameter (@{$args{'parameterlist'}}) {
+	my $parameter_name = $parameter;
+	$parameter_name =~ s/\[.*//;
+
+	print ".IP \"" . $parameter . "\" 12\n";
+	output_highlight($args{'parameterdescs'}{$parameter_name});
+    }
+    foreach $section (@{$args{'sectionlist'}}) {
+	print ".SH \"", uc $section, "\"\n";
+	output_highlight($args{'sections'}{$section});
+    }
+}
+
+##
+# output enum in man
+sub output_enum_man(%) {
+    my %args = %{$_[0]};
+    my ($parameter, $section);
+    my $count;
+
+    print ".TH \"$args{'module'}\" 9 \"enum $args{'enum'}\" \"$man_date\" \"API Manual\" LINUX\n";
+
+    print ".SH NAME\n";
+    print "enum " . $args{'enum'} . " \\- " . $args{'purpose'} . "\n";
+
+    print ".SH SYNOPSIS\n";
+    print "enum " . $args{'enum'} . " {\n";
+    $count = 0;
+    foreach my $parameter (@{$args{'parameterlist'}}) {
+	print ".br\n.BI \"    $parameter\"\n";
+	if ($count == $#{$args{'parameterlist'}}) {
+	    print "\n};\n";
+	    last;
+	}
+	else {
+	    print ", \n.br\n";
+	}
+	$count++;
+    }
+
+    print ".SH Constants\n";
+    foreach $parameter (@{$args{'parameterlist'}}) {
+	my $parameter_name = $parameter;
+	$parameter_name =~ s/\[.*//;
+
+	print ".IP \"" . $parameter . "\" 12\n";
+	output_highlight($args{'parameterdescs'}{$parameter_name});
+    }
+    foreach $section (@{$args{'sectionlist'}}) {
+	print ".SH \"$section\"\n";
+	output_highlight($args{'sections'}{$section});
+    }
+}
+
+##
+# output struct in man
+sub output_struct_man(%) {
+    my %args = %{$_[0]};
+    my ($parameter, $section);
+
+    print ".TH \"$args{'module'}\" 9 \"" . $args{'type'} . " " . $args{'struct'} . "\" \"$man_date\" \"API Manual\" LINUX\n";
+
+    print ".SH NAME\n";
+    print $args{'type'} . " " . $args{'struct'} . " \\- " . $args{'purpose'} . "\n";
+
+    my $declaration = $args{'definition'};
+    $declaration =~ s/\t/  /g;
+    $declaration =~ s/\n/"\n.br\n.BI \"/g;
+    print ".SH SYNOPSIS\n";
+    print $args{'type'} . " " . $args{'struct'} . " {\n.br\n";
+    print ".BI \"$declaration\n};\n.br\n\n";
+
+    print ".SH Members\n";
+    foreach $parameter (@{$args{'parameterlist'}}) {
+	($parameter =~ /^#/) && next;
+
+	my $parameter_name = $parameter;
+	$parameter_name =~ s/\[.*//;
+
+	($args{'parameterdescs'}{$parameter_name} ne $undescribed) || next;
+	print ".IP \"" . $parameter . "\" 12\n";
+	output_highlight($args{'parameterdescs'}{$parameter_name});
+    }
+    foreach $section (@{$args{'sectionlist'}}) {
+	print ".SH \"$section\"\n";
+	output_highlight($args{'sections'}{$section});
+    }
+}
+
+##
+# output typedef in man
+sub output_typedef_man(%) {
+    my %args = %{$_[0]};
+    my ($parameter, $section);
+
+    print ".TH \"$args{'module'}\" 9 \"$args{'typedef'}\" \"$man_date\" \"API Manual\" LINUX\n";
+
+    print ".SH NAME\n";
+    print "typedef " . $args{'typedef'} . " \\- " . $args{'purpose'} . "\n";
+
+    foreach $section (@{$args{'sectionlist'}}) {
+	print ".SH \"$section\"\n";
+	output_highlight($args{'sections'}{$section});
+    }
+}
+
+sub output_blockhead_man(%) {
+    my %args = %{$_[0]};
+    my ($parameter, $section);
+    my $count;
+
+    print ".TH \"$args{'module'}\" 9 \"$args{'module'}\" \"$man_date\" \"API Manual\" LINUX\n";
+
+    foreach $section (@{$args{'sectionlist'}}) {
+	print ".SH \"$section\"\n";
+	output_highlight($args{'sections'}{$section});
+    }
+}
+
+##
+# output in restructured text
+#
+
+#
+# This could use some work; it's used to output the DOC: sections, and
+# starts by putting out the name of the doc section itself, but that tends
+# to duplicate a header already in the template file.
+#
+sub output_blockhead_rst(%) {
+    my %args = %{$_[0]};
+    my ($parameter, $section);
+
+    foreach $section (@{$args{'sectionlist'}}) {
+	next if (defined($nosymbol_table{$section}));
+
+	if ($output_selection != OUTPUT_INCLUDE) {
+	    print ".. _$section:\n\n";
+	    print "**$section**\n\n";
+	}
+        print_lineno($section_start_lines{$section});
+	output_highlight_rst($args{'sections'}{$section});
+	print "\n";
+    }
+}
+
+#
+# Apply the RST highlights to a sub-block of text.
+#
+sub highlight_block($) {
+    # The dohighlight kludge requires the text be called $contents
+    my $contents = shift;
+    eval $dohighlight;
+    die $@ if $@;
+    return $contents;
+}
+
+#
+# Regexes used only here.
+#
+my $sphinx_literal = '^[^.].*::$';
+my $sphinx_cblock = '^\.\.\ +code-block::';
+
+sub output_highlight_rst {
+    my $input = join "\n",@_;
+    my $output = "";
+    my $line;
+    my $in_literal = 0;
+    my $litprefix;
+    my $block = "";
+
+    foreach $line (split "\n",$input) {
+	#
+	# If we're in a literal block, see if we should drop out
+	# of it.  Otherwise pass the line straight through unmunged.
+	#
+	if ($in_literal) {
+	    if (! ($line =~ /^\s*$/)) {
+		#
+		# If this is the first non-blank line in a literal
+		# block we need to figure out what the proper indent is.
+		#
+		if ($litprefix eq "") {
+		    $line =~ /^(\s*)/;
+		    $litprefix = '^' . $1;
+		    $output .= $line . "\n";
+		} elsif (! ($line =~ /$litprefix/)) {
+		    $in_literal = 0;
+		} else {
+		    $output .= $line . "\n";
+		}
+	    } else {
+		$output .= $line . "\n";
+	    }
+	}
+	#
+	# Not in a literal block (or just dropped out)
+	#
+	if (! $in_literal) {
+	    $block .= $line . "\n";
+	    if (($line =~ /$sphinx_literal/) || ($line =~ /$sphinx_cblock/)) {
+		$in_literal = 1;
+		$litprefix = "";
+		$output .= highlight_block($block);
+		$block = ""
+	    }
+	}
+    }
+
+    if ($block) {
+	$output .= highlight_block($block);
+    }
+    foreach $line (split "\n", $output) {
+	print $lineprefix . $line . "\n";
+    }
+}
+
+sub output_function_rst(%) {
+    my %args = %{$_[0]};
+    my ($parameter, $section);
+    my $oldprefix = $lineprefix;
+    my $start = "";
+    my $is_macro = 0;
+
+    if ($sphinx_major < 3) {
+	if ($args{'typedef'}) {
+	    print ".. c:type:: ". $args{'function'} . "\n\n";
+	    print_lineno($declaration_start_line);
+	    print "   **Typedef**: ";
+	    $lineprefix = "";
+	    output_highlight_rst($args{'purpose'});
+	    $start = "\n\n**Syntax**\n\n  ``";
+	    $is_macro = 1;
+	} else {
+	    print ".. c:function:: ";
+	}
+    } else {
+	if ($args{'typedef'} || $args{'functiontype'} eq "") {
+	    $is_macro = 1;
+	    print ".. c:macro:: ". $args{'function'} . "\n\n";
+	} else {
+	    print ".. c:function:: ";
+	}
+
+	if ($args{'typedef'}) {
+	    print_lineno($declaration_start_line);
+	    print "   **Typedef**: ";
+	    $lineprefix = "";
+	    output_highlight_rst($args{'purpose'});
+	    $start = "\n\n**Syntax**\n\n  ``";
+	} else {
+	    print "``" if ($is_macro);
+	}
+    }
+    if ($args{'functiontype'} ne "") {
+	$start .= $args{'functiontype'} . " " . $args{'function'} . " (";
+    } else {
+	$start .= $args{'function'} . " (";
+    }
+    print $start;
+
+    my $count = 0;
+    foreach my $parameter (@{$args{'parameterlist'}}) {
+	if ($count ne 0) {
+	    print ", ";
+	}
+	$count++;
+	$type = $args{'parametertypes'}{$parameter};
+
+	if ($type =~ m/$function_pointer/) {
+	    # pointer-to-function
+	    print $1 . $parameter . ") (" . $2 . ")";
+	} else {
+	    print $type;
+	}
+    }
+    if ($is_macro) {
+	print ")``\n\n";
+    } else {
+	print ")\n\n";
+    }
+    if (!$args{'typedef'}) {
+	print_lineno($declaration_start_line);
+	$lineprefix = "   ";
+	output_highlight_rst($args{'purpose'});
+	print "\n";
+    }
+
+    #
+    # Put our descriptive text into a container (thus an HTML <div>) to help
+    # set the function prototypes apart.
+    #
+    print ".. container:: kernelindent\n\n";
+    $lineprefix = "  ";
+    print $lineprefix . "**Parameters**\n\n";
+    foreach $parameter (@{$args{'parameterlist'}}) {
+	my $parameter_name = $parameter;
+	$parameter_name =~ s/\[.*//;
+	$type = $args{'parametertypes'}{$parameter};
+
+	if ($type ne "") {
+	    print $lineprefix . "``$type``\n";
+	} else {
+	    print $lineprefix . "``$parameter``\n";
+	}
+
+        print_lineno($parameterdesc_start_lines{$parameter_name});
+
+	$lineprefix = "    ";
+	if (defined($args{'parameterdescs'}{$parameter_name}) &&
+	    $args{'parameterdescs'}{$parameter_name} ne $undescribed) {
+	    output_highlight_rst($args{'parameterdescs'}{$parameter_name});
+	} else {
+	    print $lineprefix . "*undescribed*\n";
+	}
+	$lineprefix = "  ";
+	print "\n";
+    }
+
+    output_section_rst(@_);
+    $lineprefix = $oldprefix;
+}
+
+sub output_section_rst(%) {
+    my %args = %{$_[0]};
+    my $section;
+    my $oldprefix = $lineprefix;
+
+    foreach $section (@{$args{'sectionlist'}}) {
+	print $lineprefix . "**$section**\n\n";
+        print_lineno($section_start_lines{$section});
+	output_highlight_rst($args{'sections'}{$section});
+	print "\n";
+    }
+    print "\n";
+}
+
+sub output_enum_rst(%) {
+    my %args = %{$_[0]};
+    my ($parameter);
+    my $oldprefix = $lineprefix;
+    my $count;
+    my $outer;
+
+    if ($sphinx_major < 3) {
+	my $name = "enum " . $args{'enum'};
+	print "\n\n.. c:type:: " . $name . "\n\n";
+    } else {
+	my $name = $args{'enum'};
+	print "\n\n.. c:enum:: " . $name . "\n\n";
+    }
+    print_lineno($declaration_start_line);
+    $lineprefix = "  ";
+    output_highlight_rst($args{'purpose'});
+    print "\n";
+
+    print ".. container:: kernelindent\n\n";
+    $outer = $lineprefix . "  ";
+    $lineprefix = $outer . "  ";
+    print $outer . "**Constants**\n\n";
+    foreach $parameter (@{$args{'parameterlist'}}) {
+	print $outer . "``$parameter``\n";
+
+	if ($args{'parameterdescs'}{$parameter} ne $undescribed) {
+	    output_highlight_rst($args{'parameterdescs'}{$parameter});
+	} else {
+	    print $lineprefix . "*undescribed*\n";
+	}
+	print "\n";
+    }
+    print "\n";
+    $lineprefix = $oldprefix;
+    output_section_rst(@_);
+}
+
+sub output_typedef_rst(%) {
+    my %args = %{$_[0]};
+    my ($parameter);
+    my $oldprefix = $lineprefix;
+    my $name;
+
+    if ($sphinx_major < 3) {
+	$name = "typedef " . $args{'typedef'};
+    } else {
+	$name = $args{'typedef'};
+    }
+    print "\n\n.. c:type:: " . $name . "\n\n";
+    print_lineno($declaration_start_line);
+    $lineprefix = "   ";
+    output_highlight_rst($args{'purpose'});
+    print "\n";
+
+    $lineprefix = $oldprefix;
+    output_section_rst(@_);
+}
+
+sub output_struct_rst(%) {
+    my %args = %{$_[0]};
+    my ($parameter);
+    my $oldprefix = $lineprefix;
+
+    if ($sphinx_major < 3) {
+	my $name = $args{'type'} . " " . $args{'struct'};
+	print "\n\n.. c:type:: " . $name . "\n\n";
+    } else {
+	my $name = $args{'struct'};
+	if ($args{'type'} eq 'union') {
+	    print "\n\n.. c:union:: " . $name . "\n\n";
+	} else {
+	    print "\n\n.. c:struct:: " . $name . "\n\n";
+	}
+    }
+    print_lineno($declaration_start_line);
+    $lineprefix = "  ";
+    output_highlight_rst($args{'purpose'});
+    print "\n";
+
+    print ".. container:: kernelindent\n\n";
+    print $lineprefix . "**Definition**::\n\n";
+    my $declaration = $args{'definition'};
+    $lineprefix = $lineprefix . "  ";
+    $declaration =~ s/\t/$lineprefix/g;
+    print $lineprefix . $args{'type'} . " " . $args{'struct'} . " {\n$declaration" . $lineprefix . "};\n\n";
+
+    $lineprefix = "  ";
+    print $lineprefix . "**Members**\n\n";
+    foreach $parameter (@{$args{'parameterlist'}}) {
+	($parameter =~ /^#/) && next;
+
+	my $parameter_name = $parameter;
+	$parameter_name =~ s/\[.*//;
+
+	($args{'parameterdescs'}{$parameter_name} ne $undescribed) || next;
+	$type = $args{'parametertypes'}{$parameter};
+        print_lineno($parameterdesc_start_lines{$parameter_name});
+	print $lineprefix . "``" . $parameter . "``\n";
+	$lineprefix = "    ";
+	output_highlight_rst($args{'parameterdescs'}{$parameter_name});
+	$lineprefix = "  ";
+	print "\n";
+    }
+    print "\n";
+
+    $lineprefix = $oldprefix;
+    output_section_rst(@_);
+}
+
+## none mode output functions
+
+sub output_function_none(%) {
+}
+
+sub output_enum_none(%) {
+}
+
+sub output_typedef_none(%) {
+}
+
+sub output_struct_none(%) {
+}
+
+sub output_blockhead_none(%) {
+}
+
+##
+# generic output function for all types (function, struct/union, typedef, enum);
+# calls the generated, variable output_ function name based on
+# functype and output_mode
+sub output_declaration {
+    no strict 'refs';
+    my $name = shift;
+    my $functype = shift;
+    my $func = "output_${functype}_$output_mode";
+
+    return if (defined($nosymbol_table{$name}));
+
+    if (($output_selection == OUTPUT_ALL) ||
+	(($output_selection == OUTPUT_INCLUDE ||
+	  $output_selection == OUTPUT_EXPORTED) &&
+	 defined($function_table{$name})) ||
+	($output_selection == OUTPUT_INTERNAL &&
+	 !($functype eq "function" && defined($function_table{$name}))))
+    {
+	&$func(@_);
+	$section_counter++;
+    }
+}
+
+##
+# generic output function - calls the right one based on current output mode.
+sub output_blockhead {
+    no strict 'refs';
+    my $func = "output_blockhead_" . $output_mode;
+    &$func(@_);
+    $section_counter++;
+}
+
+##
+# takes a declaration (struct, union, enum, typedef) and
+# invokes the right handler. NOT called for functions.
+sub dump_declaration($$) {
+    no strict 'refs';
+    my ($prototype, $file) = @_;
+    my $func = "dump_" . $decl_type;
+    &$func(@_);
+}
+
+sub dump_union($$) {
+    dump_struct(@_);
+}
+
+sub dump_struct($$) {
+    my $x = shift;
+    my $file = shift;
+    my $decl_type;
+    my $members;
+    my $type = qr{struct|union};
+    # For capturing struct/union definition body, i.e. "{members*}qualifiers*"
+    my $qualifiers = qr{$attribute|__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned};
+    my $definition_body = qr{\{(.*)\}\s*$qualifiers*};
+    my $struct_members = qr{($type)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;};
+
+    if ($x =~ /($type)\s+(\w+)\s*$definition_body/) {
+	$decl_type = $1;
+	$declaration_name = $2;
+	$members = $3;
+    } elsif ($x =~ /typedef\s+($type)\s*$definition_body\s*(\w+)\s*;/) {
+	$decl_type = $1;
+	$declaration_name = $3;
+	$members = $2;
+    }
+
+    if ($members) {
+	if ($identifier ne $declaration_name) {
+	    emit_warning("${file}:$.", "expecting prototype for $decl_type $identifier. Prototype was for $decl_type $declaration_name instead\n");
+	    return;
+	}
+
+	# ignore members marked private:
+	$members =~ s/\/\*\s*private:.*?\/\*\s*public:.*?\*\///gosi;
+	$members =~ s/\/\*\s*private:.*//gosi;
+	# strip comments:
+	$members =~ s/\/\*.*?\*\///gos;
+	# strip attributes
+	$members =~ s/\s*$attribute/ /gi;
+	$members =~ s/\s*__aligned\s*\([^;]*\)/ /gos;
+	$members =~ s/\s*__packed\s*/ /gos;
+	$members =~ s/\s*CRYPTO_MINALIGN_ATTR/ /gos;
+	$members =~ s/\s*____cacheline_aligned_in_smp/ /gos;
+	$members =~ s/\s*____cacheline_aligned/ /gos;
+	# unwrap struct_group():
+	# - first eat non-declaration parameters and rewrite for final match
+	# - then remove macro, outer parens, and trailing semicolon
+	$members =~ s/\bstruct_group\s*\(([^,]*,)/STRUCT_GROUP(/gos;
+	$members =~ s/\bstruct_group_(attr|tagged)\s*\(([^,]*,){2}/STRUCT_GROUP(/gos;
+	$members =~ s/\b__struct_group\s*\(([^,]*,){3}/STRUCT_GROUP(/gos;
+	$members =~ s/\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;/$2/gos;
+
+	my $args = qr{([^,)]+)};
+	# replace DECLARE_BITMAP
+	$members =~ s/__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)/DECLARE_BITMAP($1, __ETHTOOL_LINK_MODE_MASK_NBITS)/gos;
+	$members =~ s/DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)/DECLARE_BITMAP($1, PHY_INTERFACE_MODE_MAX)/gos;
+	$members =~ s/DECLARE_BITMAP\s*\($args,\s*$args\)/unsigned long $1\[BITS_TO_LONGS($2)\]/gos;
+	# replace DECLARE_HASHTABLE
+	$members =~ s/DECLARE_HASHTABLE\s*\($args,\s*$args\)/unsigned long $1\[1 << (($2) - 1)\]/gos;
+	# replace DECLARE_KFIFO
+	$members =~ s/DECLARE_KFIFO\s*\($args,\s*$args,\s*$args\)/$2 \*$1/gos;
+	# replace DECLARE_KFIFO_PTR
+	$members =~ s/DECLARE_KFIFO_PTR\s*\($args,\s*$args\)/$2 \*$1/gos;
+	# replace DECLARE_FLEX_ARRAY
+	$members =~ s/(?:__)?DECLARE_FLEX_ARRAY\s*\($args,\s*$args\)/$1 $2\[\]/gos;
+	#replace DEFINE_DMA_UNMAP_ADDR
+	$members =~ s/DEFINE_DMA_UNMAP_ADDR\s*\($args\)/dma_addr_t $1/gos;
+	#replace DEFINE_DMA_UNMAP_LEN
+	$members =~ s/DEFINE_DMA_UNMAP_LEN\s*\($args\)/__u32 $1/gos;
+	my $declaration = $members;
+
+	# Split nested struct/union elements as newer ones
+	while ($members =~ m/$struct_members/) {
+		my $newmember;
+		my $maintype = $1;
+		my $ids = $4;
+		my $content = $3;
+		foreach my $id(split /,/, $ids) {
+			$newmember .= "$maintype $id; ";
+
+			$id =~ s/[:\[].*//;
+			$id =~ s/^\s*\**(\S+)\s*/$1/;
+			foreach my $arg (split /;/, $content) {
+				next if ($arg =~ m/^\s*$/);
+				if ($arg =~ m/^([^\(]+\(\*?\s*)([\w\.]*)(\s*\).*)/) {
+					# pointer-to-function
+					my $type = $1;
+					my $name = $2;
+					my $extra = $3;
+					next if (!$name);
+					if ($id =~ m/^\s*$/) {
+						# anonymous struct/union
+						$newmember .= "$type$name$extra; ";
+					} else {
+						$newmember .= "$type$id.$name$extra; ";
+					}
+				} else {
+					my $type;
+					my $names;
+					$arg =~ s/^\s+//;
+					$arg =~ s/\s+$//;
+					# Handle bitmaps
+					$arg =~ s/:\s*\d+\s*//g;
+					# Handle arrays
+					$arg =~ s/\[.*\]//g;
+					# The type may have multiple words,
+					# and multiple IDs can be defined, like:
+					#	const struct foo, *bar, foobar
+					# So, we remove spaces when parsing the
+					# names, in order to match just names
+					# and commas for the names
+					$arg =~ s/\s*,\s*/,/g;
+					if ($arg =~ m/(.*)\s+([\S+,]+)/) {
+						$type = $1;
+						$names = $2;
+					} else {
+						$newmember .= "$arg; ";
+						next;
+					}
+					foreach my $name (split /,/, $names) {
+						$name =~ s/^\s*\**(\S+)\s*/$1/;
+						next if (($name =~ m/^\s*$/));
+						if ($id =~ m/^\s*$/) {
+							# anonymous struct/union
+							$newmember .= "$type $name; ";
+						} else {
+							$newmember .= "$type $id.$name; ";
+						}
+					}
+				}
+			}
+		}
+		$members =~ s/$struct_members/$newmember/;
+	}
+
+	# Ignore other nested elements, like enums
+	$members =~ s/(\{[^\{\}]*\})//g;
+
+	create_parameterlist($members, ';', $file, $declaration_name);
+	check_sections($file, $declaration_name, $decl_type, $sectcheck, $struct_actual);
+
+	# Adjust declaration for better display
+	$declaration =~ s/([\{;])/$1\n/g;
+	$declaration =~ s/\}\s+;/};/g;
+	# Better handle inlined enums
+	do {} while ($declaration =~ s/(enum\s+\{[^\}]+),([^\n])/$1,\n$2/);
+
+	my @def_args = split /\n/, $declaration;
+	my $level = 1;
+	$declaration = "";
+	foreach my $clause (@def_args) {
+		$clause =~ s/^\s+//;
+		$clause =~ s/\s+$//;
+		$clause =~ s/\s+/ /;
+		next if (!$clause);
+		$level-- if ($clause =~ m/(\})/ && $level > 1);
+		if (!($clause =~ m/^\s*#/)) {
+			$declaration .= "\t" x $level;
+		}
+		$declaration .= "\t" . $clause . "\n";
+		$level++ if ($clause =~ m/(\{)/ && !($clause =~m/\}/));
+	}
+	output_declaration($declaration_name,
+			   'struct',
+			   {'struct' => $declaration_name,
+			    'module' => $modulename,
+			    'definition' => $declaration,
+			    'parameterlist' => \@parameterlist,
+			    'parameterdescs' => \%parameterdescs,
+			    'parametertypes' => \%parametertypes,
+			    'sectionlist' => \@sectionlist,
+			    'sections' => \%sections,
+			    'purpose' => $declaration_purpose,
+			    'type' => $decl_type
+			   });
+    }
+    else {
+	print STDERR "${file}:$.: error: Cannot parse struct or union!\n";
+	++$errors;
+    }
+}
+
+
+sub show_warnings($$) {
+	my $functype = shift;
+	my $name = shift;
+
+	return 0 if (defined($nosymbol_table{$name}));
+
+	return 1 if ($output_selection == OUTPUT_ALL);
+
+	if ($output_selection == OUTPUT_EXPORTED) {
+		if (defined($function_table{$name})) {
+			return 1;
+		} else {
+			return 0;
+		}
+	}
+        if ($output_selection == OUTPUT_INTERNAL) {
+		if (!($functype eq "function" && defined($function_table{$name}))) {
+			return 1;
+		} else {
+			return 0;
+		}
+	}
+	if ($output_selection == OUTPUT_INCLUDE) {
+		if (defined($function_table{$name})) {
+			return 1;
+		} else {
+			return 0;
+		}
+	}
+	die("Please add the new output type at show_warnings()");
+}
+
+sub dump_enum($$) {
+    my $x = shift;
+    my $file = shift;
+    my $members;
+
+    # ignore members marked private:
+    $x =~ s/\/\*\s*private:.*?\/\*\s*public:.*?\*\///gosi;
+    $x =~ s/\/\*\s*private:.*}/}/gosi;
+
+    $x =~ s@/\*.*?\*/@@gos;	# strip comments.
+    # strip #define macros inside enums
+    $x =~ s@#\s*((define|ifdef)\s+|endif)[^;]*;@@gos;
+
+    if ($x =~ /typedef\s+enum\s*\{(.*)\}\s*(\w*)\s*;/) {
+	$declaration_name = $2;
+	$members = $1;
+    } elsif ($x =~ /enum\s+(\w*)\s*\{(.*)\}/) {
+	$declaration_name = $1;
+	$members = $2;
+    }
+
+    if ($members) {
+	if ($identifier ne $declaration_name) {
+	    if ($identifier eq "") {
+		emit_warning("${file}:$.", "wrong kernel-doc identifier on line:\n");
+	    } else {
+		emit_warning("${file}:$.", "expecting prototype for enum $identifier. Prototype was for enum $declaration_name instead\n");
+	    }
+	    return;
+	}
+	$declaration_name = "(anonymous)" if ($declaration_name eq "");
+
+	my %_members;
+
+	$members =~ s/\s+$//;
+	$members =~ s/\([^;]*?[\)]//g;
+
+	foreach my $arg (split ',', $members) {
+	    $arg =~ s/^\s*(\w+).*/$1/;
+	    push @parameterlist, $arg;
+	    if (!$parameterdescs{$arg}) {
+		$parameterdescs{$arg} = $undescribed;
+	        if (show_warnings("enum", $declaration_name)) {
+			emit_warning("${file}:$.", "Enum value '$arg' not described in enum '$declaration_name'\n");
+		}
+	    }
+	    $_members{$arg} = 1;
+	}
+
+	while (my ($k, $v) = each %parameterdescs) {
+	    if (!exists($_members{$k})) {
+	        if (show_warnings("enum", $declaration_name)) {
+		     emit_warning("${file}:$.", "Excess enum value '$k' description in '$declaration_name'\n");
+		}
+	    }
+        }
+
+	output_declaration($declaration_name,
+			   'enum',
+			   {'enum' => $declaration_name,
+			    'module' => $modulename,
+			    'parameterlist' => \@parameterlist,
+			    'parameterdescs' => \%parameterdescs,
+			    'sectionlist' => \@sectionlist,
+			    'sections' => \%sections,
+			    'purpose' => $declaration_purpose
+			   });
+    } else {
+	print STDERR "${file}:$.: error: Cannot parse enum!\n";
+	++$errors;
+    }
+}
+
+my $typedef_type = qr { ((?:\s+[\w\*]+\b){1,8})\s* }x;
+my $typedef_ident = qr { \*?\s*(\w\S+)\s* }x;
+my $typedef_args = qr { \s*\((.*)\); }x;
+
+my $typedef1 = qr { typedef$typedef_type\($typedef_ident\)$typedef_args }x;
+my $typedef2 = qr { typedef$typedef_type$typedef_ident$typedef_args }x;
+
+sub dump_typedef($$) {
+    my $x = shift;
+    my $file = shift;
+
+    $x =~ s@/\*.*?\*/@@gos;	# strip comments.
+
+    # Parse function typedef prototypes
+    if ($x =~ $typedef1 || $x =~ $typedef2) {
+	$return_type = $1;
+	$declaration_name = $2;
+	my $args = $3;
+	$return_type =~ s/^\s+//;
+
+	if ($identifier ne $declaration_name) {
+	    emit_warning("${file}:$.", "expecting prototype for typedef $identifier. Prototype was for typedef $declaration_name instead\n");
+	    return;
+	}
+
+	create_parameterlist($args, ',', $file, $declaration_name);
+
+	output_declaration($declaration_name,
+			   'function',
+			   {'function' => $declaration_name,
+			    'typedef' => 1,
+			    'module' => $modulename,
+			    'functiontype' => $return_type,
+			    'parameterlist' => \@parameterlist,
+			    'parameterdescs' => \%parameterdescs,
+			    'parametertypes' => \%parametertypes,
+			    'sectionlist' => \@sectionlist,
+			    'sections' => \%sections,
+			    'purpose' => $declaration_purpose
+			   });
+	return;
+    }
+
+    while (($x =~ /\(*.\)\s*;$/) || ($x =~ /\[*.\]\s*;$/)) {
+	$x =~ s/\(*.\)\s*;$/;/;
+	$x =~ s/\[*.\]\s*;$/;/;
+    }
+
+    if ($x =~ /typedef.*\s+(\w+)\s*;/) {
+	$declaration_name = $1;
+
+	if ($identifier ne $declaration_name) {
+	    emit_warning("${file}:$.", "expecting prototype for typedef $identifier. Prototype was for typedef $declaration_name instead\n");
+	    return;
+	}
+
+	output_declaration($declaration_name,
+			   'typedef',
+			   {'typedef' => $declaration_name,
+			    'module' => $modulename,
+			    'sectionlist' => \@sectionlist,
+			    'sections' => \%sections,
+			    'purpose' => $declaration_purpose
+			   });
+    }
+    else {
+	print STDERR "${file}:$.: error: Cannot parse typedef!\n";
+	++$errors;
+    }
+}
+
+sub save_struct_actual($) {
+    my $actual = shift;
+
+    # strip all spaces from the actual param so that it looks like one string item
+    $actual =~ s/\s*//g;
+    $struct_actual = $struct_actual . $actual . " ";
+}
+
+sub create_parameterlist($$$$) {
+    my $args = shift;
+    my $splitter = shift;
+    my $file = shift;
+    my $declaration_name = shift;
+    my $type;
+    my $param;
+
+    # temporarily replace commas inside function pointer definition
+    my $arg_expr = qr{\([^\),]+};
+    while ($args =~ /$arg_expr,/) {
+	$args =~ s/($arg_expr),/$1#/g;
+    }
+
+    foreach my $arg (split($splitter, $args)) {
+	# strip comments
+	$arg =~ s/\/\*.*\*\///;
+	# ignore argument attributes
+	$arg =~ s/\sPOS0?\s/ /;
+	# strip leading/trailing spaces
+	$arg =~ s/^\s*//;
+	$arg =~ s/\s*$//;
+	$arg =~ s/\s+/ /;
+
+	if ($arg =~ /^#/) {
+	    # Treat preprocessor directive as a typeless variable just to fill
+	    # corresponding data structures "correctly". Catch it later in
+	    # output_* subs.
+	    push_parameter($arg, "", "", $file);
+	} elsif ($arg =~ m/\(.+\)\s*\(/) {
+	    # pointer-to-function
+	    $arg =~ tr/#/,/;
+	    $arg =~ m/[^\(]+\(\*?\s*([\w\[\]\.]*)\s*\)/;
+	    $param = $1;
+	    $type = $arg;
+	    $type =~ s/([^\(]+\(\*?)\s*$param/$1/;
+	    save_struct_actual($param);
+	    push_parameter($param, $type, $arg, $file, $declaration_name);
+	} elsif ($arg) {
+	    $arg =~ s/\s*:\s*/:/g;
+	    $arg =~ s/\s*\[/\[/g;
+
+	    my @args = split('\s*,\s*', $arg);
+	    if ($args[0] =~ m/\*/) {
+		$args[0] =~ s/(\*+)\s*/ $1/;
+	    }
+
+	    my @first_arg;
+	    if ($args[0] =~ /^(.*\s+)(.*?\[.*\].*)$/) {
+		    shift @args;
+		    push(@first_arg, split('\s+', $1));
+		    push(@first_arg, $2);
+	    } else {
+		    @first_arg = split('\s+', shift @args);
+	    }
+
+	    unshift(@args, pop @first_arg);
+	    $type = join " ", @first_arg;
+
+	    foreach $param (@args) {
+		if ($param =~ m/^(\*+)\s*(.*)/) {
+		    save_struct_actual($2);
+
+		    push_parameter($2, "$type $1", $arg, $file, $declaration_name);
+		}
+		elsif ($param =~ m/(.*?):(\d+)/) {
+		    if ($type ne "") { # skip unnamed bit-fields
+			save_struct_actual($1);
+			push_parameter($1, "$type:$2", $arg, $file, $declaration_name)
+		    }
+		}
+		else {
+		    save_struct_actual($param);
+		    push_parameter($param, $type, $arg, $file, $declaration_name);
+		}
+	    }
+	}
+    }
+}
+
+sub push_parameter($$$$$) {
+	my $param = shift;
+	my $type = shift;
+	my $org_arg = shift;
+	my $file = shift;
+	my $declaration_name = shift;
+
+	if (($anon_struct_union == 1) && ($type eq "") &&
+	    ($param eq "}")) {
+		return;		# ignore the ending }; from anon. struct/union
+	}
+
+	$anon_struct_union = 0;
+	$param =~ s/[\[\)].*//;
+
+	if ($type eq "" && $param =~ /\.\.\.$/)
+	{
+	    if (!$param =~ /\w\.\.\.$/) {
+	      # handles unnamed variable parameters
+	      $param = "...";
+	    }
+	    elsif ($param =~ /\w\.\.\.$/) {
+	      # for named variable parameters of the form `x...`, remove the dots
+	      $param =~ s/\.\.\.$//;
+	    }
+	    if (!defined $parameterdescs{$param} || $parameterdescs{$param} eq "") {
+		$parameterdescs{$param} = "variable arguments";
+	    }
+	}
+	elsif ($type eq "" && ($param eq "" or $param eq "void"))
+	{
+	    $param="void";
+	    $parameterdescs{void} = "no arguments";
+	}
+	elsif ($type eq "" && ($param eq "struct" or $param eq "union"))
+	# handle unnamed (anonymous) union or struct:
+	{
+		$type = $param;
+		$param = "{unnamed_" . $param . "}";
+		$parameterdescs{$param} = "anonymous\n";
+		$anon_struct_union = 1;
+	}
+
+	# warn if parameter has no description
+	# (but ignore ones starting with # as these are not parameters
+	# but inline preprocessor statements);
+	# Note: It will also ignore void params and unnamed structs/unions
+	if (!defined $parameterdescs{$param} && $param !~ /^#/) {
+		$parameterdescs{$param} = $undescribed;
+
+	        if (show_warnings($type, $declaration_name) && $param !~ /\./) {
+			emit_warning("${file}:$.", "Function parameter or member '$param' not described in '$declaration_name'\n");
+		}
+	}
+
+	# strip spaces from $param so that it is one continuous string
+	# on @parameterlist;
+	# this fixes a problem where check_sections() cannot find
+	# a parameter like "addr[6 + 2]" because it actually appears
+	# as "addr[6", "+", "2]" on the parameter list;
+	# but it's better to maintain the param string unchanged for output,
+	# so just weaken the string compare in check_sections() to ignore
+	# "[blah" in a parameter string;
+	###$param =~ s/\s*//g;
+	push @parameterlist, $param;
+	$org_arg =~ s/\s\s+/ /g;
+	$parametertypes{$param} = $org_arg;
+}
+
+sub check_sections($$$$$) {
+	my ($file, $decl_name, $decl_type, $sectcheck, $prmscheck) = @_;
+	my @sects = split ' ', $sectcheck;
+	my @prms = split ' ', $prmscheck;
+	my $err;
+	my ($px, $sx);
+	my $prm_clean;		# strip trailing "[array size]" and/or beginning "*"
+
+	foreach $sx (0 .. $#sects) {
+		$err = 1;
+		foreach $px (0 .. $#prms) {
+			$prm_clean = $prms[$px];
+			$prm_clean =~ s/\[.*\]//;
+			$prm_clean =~ s/$attribute//i;
+			# ignore array size in a parameter string;
+			# however, the original param string may contain
+			# spaces, e.g.:  addr[6 + 2]
+			# and this appears in @prms as "addr[6" since the
+			# parameter list is split at spaces;
+			# hence just ignore "[..." for the sections check;
+			$prm_clean =~ s/\[.*//;
+
+			##$prm_clean =~ s/^\**//;
+			if ($prm_clean eq $sects[$sx]) {
+				$err = 0;
+				last;
+			}
+		}
+		if ($err) {
+			if ($decl_type eq "function") {
+				emit_warning("${file}:$.",
+					"Excess function parameter " .
+					"'$sects[$sx]' " .
+					"description in '$decl_name'\n");
+			}
+		}
+	}
+}
+
+##
+# Checks the section describing the return value of a function.
+sub check_return_section {
+        my $file = shift;
+        my $declaration_name = shift;
+        my $return_type = shift;
+
+        # Ignore an empty return type (It's a macro)
+        # Ignore functions with a "void" return type. (But don't ignore "void *")
+        if (($return_type eq "") || ($return_type =~ /void\s*\w*\s*$/)) {
+                return;
+        }
+
+        if (!defined($sections{$section_return}) ||
+            $sections{$section_return} eq "") {
+                emit_warning("${file}:$.",
+                        "No description found for return value of " .
+                        "'$declaration_name'\n");
+        }
+}
+
+##
+# takes a function prototype and the name of the current file being
+# processed and spits out all the details stored in the global
+# arrays/hashes.
+sub dump_function($$) {
+    my $prototype = shift;
+    my $file = shift;
+    my $noret = 0;
+
+    print_lineno($new_start_line);
+
+    $prototype =~ s/^static +//;
+    $prototype =~ s/^extern +//;
+    $prototype =~ s/^asmlinkage +//;
+    $prototype =~ s/^inline +//;
+    $prototype =~ s/^__inline__ +//;
+    $prototype =~ s/^__inline +//;
+    $prototype =~ s/^__always_inline +//;
+    $prototype =~ s/^noinline +//;
+    $prototype =~ s/^__FORTIFY_INLINE +//;
+    $prototype =~ s/__init +//;
+    $prototype =~ s/__init_or_module +//;
+    $prototype =~ s/__deprecated +//;
+    $prototype =~ s/__flatten +//;
+    $prototype =~ s/__meminit +//;
+    $prototype =~ s/__must_check +//;
+    $prototype =~ s/__weak +//;
+    $prototype =~ s/__sched +//;
+    $prototype =~ s/__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +//;
+    $prototype =~ s/__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +//;
+    $prototype =~ s/__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +//;
+    my $define = $prototype =~ s/^#\s*define\s+//; #ak added
+    $prototype =~ s/__attribute_const__ +//;
+    $prototype =~ s/__attribute__\s*\(\(
+            (?:
+                 [\w\s]++          # attribute name
+                 (?:\([^)]*+\))?   # attribute arguments
+                 \s*+,?            # optional comma at the end
+            )+
+          \)\)\s+//x;
+
+    # Yes, this truly is vile.  We are looking for:
+    # 1. Return type (may be nothing if we're looking at a macro)
+    # 2. Function name
+    # 3. Function parameters.
+    #
+    # All the while we have to watch out for function pointer parameters
+    # (which IIRC is what the two sections are for), C types (these
+    # regexps don't even start to express all the possibilities), and
+    # so on.
+    #
+    # If you mess with these regexps, it's a good idea to check that
+    # the following functions' documentation still comes out right:
+    # - parport_register_device (function pointer parameters)
+    # - atomic_set (macro)
+    # - pci_match_device, __copy_to_user (long return type)
+    my $name = qr{[a-zA-Z0-9_~:]+};
+    my $prototype_end1 = qr{[^\(]*};
+    my $prototype_end2 = qr{[^\{]*};
+    my $prototype_end = qr{\(($prototype_end1|$prototype_end2)\)};
+    my $type1 = qr{[\w\s]+};
+    my $type2 = qr{$type1\*+};
+
+    if ($define && $prototype =~ m/^()($name)\s+/) {
+        # This is an object-like macro, it has no return type and no parameter
+        # list.
+        # Function-like macros are not allowed to have spaces between
+        # declaration_name and opening parenthesis (notice the \s+).
+        $return_type = $1;
+        $declaration_name = $2;
+        $noret = 1;
+    } elsif ($prototype =~ m/^()($name)\s*$prototype_end/ ||
+	$prototype =~ m/^($type1)\s+($name)\s*$prototype_end/ ||
+	$prototype =~ m/^($type2+)\s*($name)\s*$prototype_end/)  {
+	$return_type = $1;
+	$declaration_name = $2;
+	my $args = $3;
+
+	create_parameterlist($args, ',', $file, $declaration_name);
+    } else {
+	emit_warning("${file}:$.", "cannot understand function prototype: '$prototype'\n");
+	return;
+    }
+
+    if ($identifier ne $declaration_name) {
+	emit_warning("${file}:$.", "expecting prototype for $identifier(). Prototype was for $declaration_name() instead\n");
+	return;
+    }
+
+    my $prms = join " ", @parameterlist;
+    check_sections($file, $declaration_name, "function", $sectcheck, $prms);
+
+    # This check emits a lot of warnings at the moment, because many
+    # functions don't have a 'Return' doc section. So until the number
+    # of warnings goes sufficiently down, the check is only performed in
+    # -Wreturn mode.
+    # TODO: always perform the check.
+    if ($Wreturn && !$noret) {
+	    check_return_section($file, $declaration_name, $return_type);
+    }
+
+    # The function parser can be called with a typedef parameter.
+    # Handle it.
+    if ($return_type =~ /typedef/) {
+	output_declaration($declaration_name,
+			   'function',
+			   {'function' => $declaration_name,
+			    'typedef' => 1,
+			    'module' => $modulename,
+			    'functiontype' => $return_type,
+			    'parameterlist' => \@parameterlist,
+			    'parameterdescs' => \%parameterdescs,
+			    'parametertypes' => \%parametertypes,
+			    'sectionlist' => \@sectionlist,
+			    'sections' => \%sections,
+			    'purpose' => $declaration_purpose
+			   });
+    } else {
+	output_declaration($declaration_name,
+			   'function',
+			   {'function' => $declaration_name,
+			    'module' => $modulename,
+			    'functiontype' => $return_type,
+			    'parameterlist' => \@parameterlist,
+			    'parameterdescs' => \%parameterdescs,
+			    'parametertypes' => \%parametertypes,
+			    'sectionlist' => \@sectionlist,
+			    'sections' => \%sections,
+			    'purpose' => $declaration_purpose
+			   });
+    }
+}
+
+sub reset_state {
+    $function = "";
+    %parameterdescs = ();
+    %parametertypes = ();
+    @parameterlist = ();
+    %sections = ();
+    @sectionlist = ();
+    $sectcheck = "";
+    $struct_actual = "";
+    $prototype = "";
+
+    $state = STATE_NORMAL;
+    $inline_doc_state = STATE_INLINE_NA;
+}
+
+sub tracepoint_munge($) {
+	my $file = shift;
+	my $tracepointname = 0;
+	my $tracepointargs = 0;
+
+	if ($prototype =~ m/TRACE_EVENT\((.*?),/) {
+		$tracepointname = $1;
+	}
+	if ($prototype =~ m/DEFINE_SINGLE_EVENT\((.*?),/) {
+		$tracepointname = $1;
+	}
+	if ($prototype =~ m/DEFINE_EVENT\((.*?),(.*?),/) {
+		$tracepointname = $2;
+	}
+	$tracepointname =~ s/^\s+//; #strip leading whitespace
+	if ($prototype =~ m/TP_PROTO\((.*?)\)/) {
+		$tracepointargs = $1;
+	}
+	if (($tracepointname eq 0) || ($tracepointargs eq 0)) {
+		emit_warning("${file}:$.", "Unrecognized tracepoint format: \n".
+			     "$prototype\n");
+	} else {
+		$prototype = "static inline void trace_$tracepointname($tracepointargs)";
+		$identifier = "trace_$identifier";
+	}
+}
+
+sub syscall_munge() {
+	my $void = 0;
+
+	$prototype =~ s@[\r\n]+@ @gos; # strip newlines/CR's
+##	if ($prototype =~ m/SYSCALL_DEFINE0\s*\(\s*(a-zA-Z0-9_)*\s*\)/) {
+	if ($prototype =~ m/SYSCALL_DEFINE0/) {
+		$void = 1;
+##		$prototype = "long sys_$1(void)";
+	}
+
+	$prototype =~ s/SYSCALL_DEFINE.*\(/long sys_/; # fix return type & func name
+	if ($prototype =~ m/long (sys_.*?),/) {
+		$prototype =~ s/,/\(/;
+	} elsif ($void) {
+		$prototype =~ s/\)/\(void\)/;
+	}
+
+	# now delete all of the odd-number commas in $prototype
+	# so that arg types & arg names don't have a comma between them
+	my $count = 0;
+	my $len = length($prototype);
+	if ($void) {
+		$len = 0;	# skip the for-loop
+	}
+	for (my $ix = 0; $ix < $len; $ix++) {
+		if (substr($prototype, $ix, 1) eq ',') {
+			$count++;
+			if ($count % 2 == 1) {
+				substr($prototype, $ix, 1) = ' ';
+			}
+		}
+	}
+}
+
+sub process_proto_function($$) {
+    my $x = shift;
+    my $file = shift;
+
+    $x =~ s@\/\/.*$@@gos; # strip C99-style comments to end of line
+
+    if ($x =~ m#\s*/\*\s+MACDOC\s*#io || ($x =~ /^#/ && $x !~ /^#\s*define/)) {
+	# do nothing
+    }
+    elsif ($x =~ /([^\{]*)/) {
+	$prototype .= $1;
+    }
+
+    if (($x =~ /\{/) || ($x =~ /\#\s*define/) || ($x =~ /;/)) {
+	$prototype =~ s@/\*.*?\*/@@gos;	# strip comments.
+	$prototype =~ s@[\r\n]+@ @gos; # strip newlines/cr's.
+	$prototype =~ s@^\s+@@gos; # strip leading spaces
+
+	 # Handle prototypes for function pointers like:
+	 # int (*pcs_config)(struct foo)
+	$prototype =~ s@^(\S+\s+)\(\s*\*(\S+)\)@$1$2@gos;
+
+	if ($prototype =~ /SYSCALL_DEFINE/) {
+		syscall_munge();
+	}
+	if ($prototype =~ /TRACE_EVENT/ || $prototype =~ /DEFINE_EVENT/ ||
+	    $prototype =~ /DEFINE_SINGLE_EVENT/)
+	{
+		tracepoint_munge($file);
+	}
+	dump_function($prototype, $file);
+	reset_state();
+    }
+}
+
+sub process_proto_type($$) {
+    my $x = shift;
+    my $file = shift;
+
+    $x =~ s@[\r\n]+@ @gos; # strip newlines/cr's.
+    $x =~ s@^\s+@@gos; # strip leading spaces
+    $x =~ s@\s+$@@gos; # strip trailing spaces
+    $x =~ s@\/\/.*$@@gos; # strip C99-style comments to end of line
+
+    if ($x =~ /^#/) {
+	# To distinguish preprocessor directive from regular declaration later.
+	$x .= ";";
+    }
+
+    while (1) {
+	if ( $x =~ /([^\{\};]*)([\{\};])(.*)/ ) {
+            if( length $prototype ) {
+                $prototype .= " "
+            }
+	    $prototype .= $1 . $2;
+	    ($2 eq '{') && $brcount++;
+	    ($2 eq '}') && $brcount--;
+	    if (($2 eq ';') && ($brcount == 0)) {
+		dump_declaration($prototype, $file);
+		reset_state();
+		last;
+	    }
+	    $x = $3;
+	} else {
+	    $prototype .= $x;
+	    last;
+	}
+    }
+}
+
+
+sub map_filename($) {
+    my $file;
+    my ($orig_file) = @_;
+
+    if (defined($ENV{'SRCTREE'})) {
+	$file = "$ENV{'SRCTREE'}" . "/" . $orig_file;
+    } else {
+	$file = $orig_file;
+    }
+
+    if (defined($source_map{$file})) {
+	$file = $source_map{$file};
+    }
+
+    return $file;
+}
+
+sub process_export_file($) {
+    my ($orig_file) = @_;
+    my $file = map_filename($orig_file);
+
+    if (!open(IN,"<$file")) {
+	print STDERR "Error: Cannot open file $file\n";
+	++$errors;
+	return;
+    }
+
+    while (<IN>) {
+	if (/$export_symbol/) {
+	    next if (defined($nosymbol_table{$2}));
+	    $function_table{$2} = 1;
+	}
+	if (/$export_symbol_ns/) {
+	    next if (defined($nosymbol_table{$2}));
+	    $function_table{$2} = 1;
+	}
+    }
+
+    close(IN);
+}
+
+#
+# Parsers for the various processing states.
+#
+# STATE_NORMAL: looking for the /** to begin everything.
+#
+sub process_normal() {
+    if (/$doc_start/o) {
+	$state = STATE_NAME;	# next line is always the function name
+	$in_doc_sect = 0;
+	$declaration_start_line = $. + 1;
+    }
+}
+
+#
+# STATE_NAME: Looking for the "name - description" line
+#
+sub process_name($$) {
+    my $file = shift;
+    my $descr;
+
+    if (/$doc_block/o) {
+	$state = STATE_DOCBLOCK;
+	$contents = "";
+	$new_start_line = $.;
+
+	if ( $1 eq "" ) {
+	    $section = $section_intro;
+	} else {
+	    $section = $1;
+	}
+    } elsif (/$doc_decl/o) {
+	$identifier = $1;
+	my $is_kernel_comment = 0;
+	my $decl_start = qr{$doc_com};
+	# test for pointer declaration type, foo * bar() - desc
+	my $fn_type = qr{\w+\s*\*\s*}; 
+	my $parenthesis = qr{\(\w*\)};
+	my $decl_end = qr{[-:].*};
+	if (/^$decl_start([\w\s]+?)$parenthesis?\s*$decl_end?$/) {
+	    $identifier = $1;
+	}
+	if ($identifier =~ m/^(struct|union|enum|typedef)\b\s*(\S*)/) {
+	    $decl_type = $1;
+	    $identifier = $2;
+	    $is_kernel_comment = 1;
+	}
+	# Look for foo() or static void foo() - description; or misspelt
+	# identifier
+	elsif (/^$decl_start$fn_type?(\w+)\s*$parenthesis?\s*$decl_end?$/ ||
+	    /^$decl_start$fn_type?(\w+.*)$parenthesis?\s*$decl_end$/) {
+	    $identifier = $1;
+	    $decl_type = 'function';
+	    $identifier =~ s/^define\s+//;
+	    $is_kernel_comment = 1;
+	}
+	$identifier =~ s/\s+$//;
+
+	$state = STATE_BODY;
+	# if there's no @param blocks need to set up default section
+	# here
+	$contents = "";
+	$section = $section_default;
+	$new_start_line = $. + 1;
+	if (/[-:](.*)/) {
+	    # strip leading/trailing/multiple spaces
+	    $descr= $1;
+	    $descr =~ s/^\s*//;
+	    $descr =~ s/\s*$//;
+	    $descr =~ s/\s+/ /g;
+	    $declaration_purpose = $descr;
+	    $state = STATE_BODY_MAYBE;
+	} else {
+	    $declaration_purpose = "";
+	}
+
+	if (!$is_kernel_comment) {
+	    emit_warning("${file}:$.", "This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst\n$_");
+	    $state = STATE_NORMAL;
+	}
+
+	if (($declaration_purpose eq "") && $Wshort_desc) {
+	    emit_warning("${file}:$.", "missing initial short description on line:\n$_");
+	}
+
+	if ($identifier eq "" && $decl_type ne "enum") {
+	    emit_warning("${file}:$.", "wrong kernel-doc identifier on line:\n$_");
+	    $state = STATE_NORMAL;
+	}
+
+	if ($verbose) {
+	    print STDERR "${file}:$.: info: Scanning doc for $decl_type $identifier\n";
+	}
+    } else {
+	emit_warning("${file}:$.", "Cannot understand $_ on line $. - I thought it was a doc line\n");
+	$state = STATE_NORMAL;
+    }
+}
+
+
+#
+# STATE_BODY and STATE_BODY_MAYBE: the bulk of a kerneldoc comment.
+#
+sub process_body($$) {
+    my $file = shift;
+
+    if ($state == STATE_BODY_WITH_BLANK_LINE && /^\s*\*\s?\S/) {
+	dump_section($file, $section, $contents);
+	$section = $section_default;
+	$new_start_line = $.;
+	$contents = "";
+    }
+
+    if (/$doc_sect/i) { # case insensitive for supported section names
+	$newsection = $1;
+	$newcontents = $2;
+
+	# map the supported section names to the canonical names
+	if ($newsection =~ m/^description$/i) {
+	    $newsection = $section_default;
+	} elsif ($newsection =~ m/^context$/i) {
+	    $newsection = $section_context;
+	} elsif ($newsection =~ m/^returns?$/i) {
+	    $newsection = $section_return;
+	} elsif ($newsection =~ m/^\@return$/) {
+	    # special: @return is a section, not a param description
+	    $newsection = $section_return;
+	}
+
+	if (($contents ne "") && ($contents ne "\n")) {
+	    if (!$in_doc_sect && $Wcontents_before_sections) {
+		emit_warning("${file}:$.", "contents before sections\n");
+	    }
+	    dump_section($file, $section, $contents);
+	    $section = $section_default;
+	}
+
+	$in_doc_sect = 1;
+	$state = STATE_BODY;
+	$contents = $newcontents;
+	$new_start_line = $.;
+	while (substr($contents, 0, 1) eq " ") {
+	    $contents = substr($contents, 1);
+	}
+	if ($contents ne "") {
+	    $contents .= "\n";
+	}
+	$section = $newsection;
+	$leading_space = undef;
+    } elsif (/$doc_end/) {
+	if (($contents ne "") && ($contents ne "\n")) {
+	    dump_section($file, $section, $contents);
+	    $section = $section_default;
+	    $contents = "";
+	}
+	# look for doc_com + <text> + doc_end:
+	if ($_ =~ m'\s*\*\s*[a-zA-Z_0-9:\.]+\*/') {
+	    emit_warning("${file}:$.", "suspicious ending line: $_");
+	}
+
+	$prototype = "";
+	$state = STATE_PROTO;
+	$brcount = 0;
+        $new_start_line = $. + 1;
+    } elsif (/$doc_content/) {
+	if ($1 eq "") {
+	    if ($section eq $section_context) {
+		dump_section($file, $section, $contents);
+		$section = $section_default;
+		$contents = "";
+		$new_start_line = $.;
+		$state = STATE_BODY;
+	    } else {
+		if ($section ne $section_default) {
+		    $state = STATE_BODY_WITH_BLANK_LINE;
+		} else {
+		    $state = STATE_BODY;
+		}
+		$contents .= "\n";
+	    }
+	} elsif ($state == STATE_BODY_MAYBE) {
+	    # Continued declaration purpose
+	    chomp($declaration_purpose);
+	    $declaration_purpose .= " " . $1;
+	    $declaration_purpose =~ s/\s+/ /g;
+	} else {
+	    my $cont = $1;
+	    if ($section =~ m/^@/ || $section eq $section_context) {
+		if (!defined $leading_space) {
+		    if ($cont =~ m/^(\s+)/) {
+			$leading_space = $1;
+		    } else {
+			$leading_space = "";
+		    }
+		}
+		$cont =~ s/^$leading_space//;
+	    }
+	    $contents .= $cont . "\n";
+	}
+    } else {
+	# i dont know - bad line?  ignore.
+	emit_warning("${file}:$.", "bad line: $_");
+    }
+}
+
+
+#
+# STATE_PROTO: reading a function/whatever prototype.
+#
+sub process_proto($$) {
+    my $file = shift;
+
+    if (/$doc_inline_oneline/) {
+	$section = $1;
+	$contents = $2;
+	if ($contents ne "") {
+	    $contents .= "\n";
+	    dump_section($file, $section, $contents);
+	    $section = $section_default;
+	    $contents = "";
+	}
+    } elsif (/$doc_inline_start/) {
+	$state = STATE_INLINE;
+	$inline_doc_state = STATE_INLINE_NAME;
+    } elsif ($decl_type eq 'function') {
+	process_proto_function($_, $file);
+    } else {
+	process_proto_type($_, $file);
+    }
+}
+
+#
+# STATE_DOCBLOCK: within a DOC: block.
+#
+sub process_docblock($$) {
+    my $file = shift;
+
+    if (/$doc_end/) {
+	dump_doc_section($file, $section, $contents);
+	$section = $section_default;
+	$contents = "";
+	$function = "";
+	%parameterdescs = ();
+	%parametertypes = ();
+	@parameterlist = ();
+	%sections = ();
+	@sectionlist = ();
+	$prototype = "";
+	$state = STATE_NORMAL;
+    } elsif (/$doc_content/) {
+	if ( $1 eq "" )	{
+	    $contents .= $blankline;
+	} else {
+	    $contents .= $1 . "\n";
+	}
+    }
+}
+
+#
+# STATE_INLINE: docbook comments within a prototype.
+#
+sub process_inline($$) {
+    my $file = shift;
+
+    # First line (state 1) needs to be a @parameter
+    if ($inline_doc_state == STATE_INLINE_NAME && /$doc_inline_sect/o) {
+	$section = $1;
+	$contents = $2;
+	$new_start_line = $.;
+	if ($contents ne "") {
+	    while (substr($contents, 0, 1) eq " ") {
+		$contents = substr($contents, 1);
+	    }
+	    $contents .= "\n";
+	}
+	$inline_doc_state = STATE_INLINE_TEXT;
+	# Documentation block end */
+    } elsif (/$doc_inline_end/) {
+	if (($contents ne "") && ($contents ne "\n")) {
+	    dump_section($file, $section, $contents);
+	    $section = $section_default;
+	    $contents = "";
+	}
+	$state = STATE_PROTO;
+	$inline_doc_state = STATE_INLINE_NA;
+	# Regular text
+    } elsif (/$doc_content/) {
+	if ($inline_doc_state == STATE_INLINE_TEXT) {
+	    $contents .= $1 . "\n";
+	    # nuke leading blank lines
+	    if ($contents =~ /^\s*$/) {
+		$contents = "";
+	    }
+	} elsif ($inline_doc_state == STATE_INLINE_NAME) {
+	    $inline_doc_state = STATE_INLINE_ERROR;
+	    emit_warning("${file}:$.", "Incorrect use of kernel-doc format: $_");
+	}
+    }
+}
+
+
+sub process_file($) {
+    my $file;
+    my $initial_section_counter = $section_counter;
+    my ($orig_file) = @_;
+
+    $file = map_filename($orig_file);
+
+    if (!open(IN_FILE,"<$file")) {
+	print STDERR "Error: Cannot open file $file\n";
+	++$errors;
+	return;
+    }
+
+    $. = 1;
+
+    $section_counter = 0;
+    while (<IN_FILE>) {
+	while (s/\\\s*$//) {
+	    $_ .= <IN_FILE>;
+	}
+	# Replace tabs by spaces
+        while ($_ =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {};
+	# Hand this line to the appropriate state handler
+	if ($state == STATE_NORMAL) {
+	    process_normal();
+	} elsif ($state == STATE_NAME) {
+	    process_name($file, $_);
+	} elsif ($state == STATE_BODY || $state == STATE_BODY_MAYBE ||
+		 $state == STATE_BODY_WITH_BLANK_LINE) {
+	    process_body($file, $_);
+	} elsif ($state == STATE_INLINE) { # scanning for inline parameters
+	    process_inline($file, $_);
+	} elsif ($state == STATE_PROTO) {
+	    process_proto($file, $_);
+	} elsif ($state == STATE_DOCBLOCK) {
+	    process_docblock($file, $_);
+	}
+    }
+
+    # Make sure we got something interesting.
+    if ($initial_section_counter == $section_counter && $
+	output_mode ne "none") {
+	if ($output_selection == OUTPUT_INCLUDE) {
+	    emit_warning("${file}:1", "'$_' not found\n")
+		for keys %function_table;
+	}
+	else {
+	    emit_warning("${file}:1", "no structured comments found\n");
+	}
+    }
+    close IN_FILE;
+}
+
+
+if ($output_mode eq "rst") {
+	get_sphinx_version() if (!$sphinx_major);
+}
+
+$kernelversion = get_kernel_version();
+
+# generate a sequence of code that will splice in highlighting information
+# using the s// operator.
+for (my $k = 0; $k < @highlights; $k++) {
+    my $pattern = $highlights[$k][0];
+    my $result = $highlights[$k][1];
+#   print STDERR "scanning pattern:$pattern, highlight:($result)\n";
+    $dohighlight .=  "\$contents =~ s:$pattern:$result:gs;\n";
+}
+
+# Read the file that maps relative names to absolute names for
+# separate source and object directories and for shadow trees.
+if (open(SOURCE_MAP, "<.tmp_filelist.txt")) {
+	my ($relname, $absname);
+	while(<SOURCE_MAP>) {
+		chop();
+		($relname, $absname) = (split())[0..1];
+		$relname =~ s:^/+::;
+		$source_map{$relname} = $absname;
+	}
+	close(SOURCE_MAP);
+}
+
+if ($output_selection == OUTPUT_EXPORTED ||
+    $output_selection == OUTPUT_INTERNAL) {
+
+    push(@export_file_list, @ARGV);
+
+    foreach (@export_file_list) {
+	chomp;
+	process_export_file($_);
+    }
+}
+
+foreach (@ARGV) {
+    chomp;
+    process_file($_);
+}
+if ($verbose && $errors) {
+  print STDERR "$errors errors\n";
+}
+if ($verbose && $warnings) {
+  print STDERR "$warnings warnings\n";
+}
+
+if ($Werror && $warnings) {
+    print STDERR "$warnings warnings as Errors\n";
+    exit($warnings);
+} else {
+    exit($output_mode eq "none" ? 0 : $errors)
+}
+
+__END__
+
+=head1 OPTIONS
+
+=head2 Output format selection (mutually exclusive):
+
+=over 8
+
+=item -man
+
+Output troff manual page format.
+
+=item -rst
+
+Output reStructuredText format. This is the default.
+
+=item -none
+
+Do not output documentation, only warnings.
+
+=back
+
+=head2 Output format modifiers
+
+=head3 reStructuredText only
+
+=over 8
+
+=item -sphinx-version VERSION
+
+Use the ReST C domain dialect compatible with a specific Sphinx Version.
+
+If not specified, kernel-doc will auto-detect using the sphinx-build version
+found on PATH.
+
+=back
+
+=head2 Output selection (mutually exclusive):
+
+=over 8
+
+=item -export
+
+Only output documentation for the symbols that have been exported using
+EXPORT_SYMBOL() and related macros in any input FILE or -export-file FILE.
+
+=item -internal
+
+Only output documentation for the symbols that have NOT been exported using
+EXPORT_SYMBOL() and related macros in any input FILE or -export-file FILE.
+
+=item -function NAME
+
+Only output documentation for the given function or DOC: section title.
+All other functions and DOC: sections are ignored.
+
+May be specified multiple times.
+
+=item -nosymbol NAME
+
+Exclude the specified symbol from the output documentation.
+
+May be specified multiple times.
+
+=back
+
+=head2 Output selection modifiers:
+
+=over 8
+
+=item -no-doc-sections
+
+Do not output DOC: sections.
+
+=item -export-file FILE
+
+Specify an additional FILE in which to look for EXPORT_SYMBOL information.
+
+To be used with -export or -internal.
+
+May be specified multiple times.
+
+=back
+
+=head3 reStructuredText only
+
+=over 8
+
+=item -enable-lineno
+
+Enable output of .. LINENO lines.
+
+=back
+
+=head2 Other parameters:
+
+=over 8
+
+=item -h, -help
+
+Print this help.
+
+=item -v
+
+Verbose output, more warnings and other information.
+
+=item -Werror
+
+Treat warnings as errors.
+
+=back
+
+=cut
-- 
2.41.0

