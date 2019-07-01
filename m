Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 061B23A339
	for <lists+linux-s390@lfdr.de>; Sun,  9 Jun 2019 04:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfFIC3R (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 8 Jun 2019 22:29:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbfFIC1e (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 Jun 2019 22:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YKLE0MAnLcwhI7ll5tzSJCvCXQFfxg7NoD5k67r4RoU=; b=nAbl8knAJ9UM1G1xqIT4ZO1UTq
        A8I7t1t1Hsx7UFMfr+xh5HyfdroS5HugqpI6lSzxkuvXON+x02ASzPhaNud+LdqWkLAec9YY28sJt
        Gp+9OCxGQNFtsW9/F+iyxKU1xrts+WCYVZrFBh0+lnibUMDVaX4oLwho12p7l5P5X2ky5DEr/gYfq
        f8J80KDJ2p9fwtv+DQHSHJqQXWw6F1txJ4hQjhyroHop62X6Zbgrol9Sbz2J7X1gCcFcOb/Df1pAE
        SQfuNk54dTA/jHwF8uEEMwvoMTEfWnDNTB3f3K4wBActF+sNBG5VgJDZvAhuPau8Q9ostR0/Y3W1i
        gPhiqviA==;
Received: from 179.176.115.133.dynamic.adsl.gvt.net.br ([179.176.115.133] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZnYS-0001n2-GB; Sun, 09 Jun 2019 02:27:32 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZnYL-0000K7-GT; Sat, 08 Jun 2019 23:27:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 25/33] docs: Debugging390.txt: convert table to ascii artwork
Date:   Sat,  8 Jun 2019 23:27:15 -0300
Message-Id: <5673b6b277b851bddfc8eb264aff489e89c9fc9d.1560045490.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560045490.git.mchehab+samsung@kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The first bit/value table inside the document is very
hard to read and won't fit ReST format. Also, some columns aren't
properly aligned.

Convert it to a nice ascii artwork table with makes it easier to
read as plain text and is compatible with ReST format parser
on Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/s390/Debugging390.txt | 210 ++++++++++++++++------------
 1 file changed, 120 insertions(+), 90 deletions(-)

diff --git a/Documentation/s390/Debugging390.txt b/Documentation/s390/Debugging390.txt
index 5ae7f868a007..c35804c238ad 100644
--- a/Documentation/s390/Debugging390.txt
+++ b/Documentation/s390/Debugging390.txt
@@ -78,96 +78,126 @@ e.g. switching address translation off requires that you
 have a logical=physical mapping for the address you are
 currently running at.
 
-      Bit           Value
-s/390 z/Architecture
-0       0     Reserved ( must be 0 ) otherwise specification exception occurs.
-
-1       1     Program Event Recording 1 PER enabled, 
-	      PER is used to facilitate debugging e.g. single stepping.
-
-2-4    2-4    Reserved ( must be 0 ). 
-
-5       5     Dynamic address translation 1=DAT on.
-
-6       6     Input/Output interrupt Mask
-
-7	7     External interrupt Mask used primarily for interprocessor
-	      signalling and clock interrupts.
-
-8-11  8-11    PSW Key used for complex memory protection mechanism
-	      (not used under linux)
-
-12      12    1 on s/390 0 on z/Architecture
-
-13      13    Machine Check Mask 1=enable machine check interrupts
-
-14	14    Wait State. Set this to 1 to stop the processor except for
-	      interrupts and give  time to other LPARS. Used in CPU idle in
-	      the kernel to increase overall usage of processor resources.
-
-15      15    Problem state ( if set to 1 certain instructions are disabled )
-	      all linux user programs run with this bit 1 
-	      ( useful info for debugging under VM ).
-
-16-17 16-17   Address Space Control
-
-	      00 Primary Space Mode:
-	      The register CR1 contains the primary address-space control ele-
-	      ment (PASCE), which points to the primary space region/segment
-	      table origin.
-
-	      01 Access register mode
-
-	      10 Secondary Space Mode:
-	      The register CR7 contains the secondary address-space control
-	      element (SASCE), which points to the secondary space region or
-	      segment table origin.
-
-	      11 Home Space Mode:
-	      The register CR13 contains the home space address-space control
-	      element (HASCE), which points to the home space region/segment
-	      table origin.
-
-	      See "Address Spaces on Linux for s/390 & z/Architecture" below
-	      for more information about address space usage in Linux.
-
-18-19 18-19   Condition codes (CC)
-
-20    20      Fixed point overflow mask if 1=FPU exceptions for this event 
-              occur ( normally 0 ) 
-
-21    21      Decimal overflow mask if 1=FPU exceptions for this event occur 
-              ( normally 0 )
-
-22    22      Exponent underflow mask if 1=FPU exceptions for this event occur 
-              ( normally 0 )
-
-23    23      Significance Mask if 1=FPU exceptions for this event occur 
-              ( normally 0 )
-
-24-31 24-30   Reserved Must be 0.
-
-      31      Extended Addressing Mode
-      32      Basic Addressing Mode
-              Used to set addressing mode
-	      PSW 31   PSW 32
-                0         0        24 bit
-                0         1        31 bit
-                1         1        64 bit
-
-32             1=31 bit addressing mode 0=24 bit addressing mode (for backward 
-               compatibility), linux always runs with this bit set to 1
-
-33-64          Instruction address.
-      33-63    Reserved must be 0
-      64-127   Address
-               In 24 bits mode bits 64-103=0 bits 104-127 Address 
-               In 31 bits mode bits 64-96=0 bits 97-127 Address
-               Note: unlike 31 bit mode on s/390 bit 96 must be zero
-	       when loading the address with LPSWE otherwise a 
-               specification exception occurs, LPSW is fully backward
-               compatible.
-
++-------------------------+-------------------------------------------------+
+|          Bit            |                                                 |
++--------+----------------+                     Value                       |
+| s/390  | z/Architecture |                                                 |
++========+================+=================================================+
+| 0      |     0          | Reserved (must be 0) otherwise specification    |
+|        |                | exception occurs.                               |
++--------+----------------+-------------------------------------------------+
+| 1      |     1          | Program Event Recording 1 PER enabled,          |
+|        |                | PER is used to facilitate debugging e.g.        |
+|        |                | single stepping.                                |
++--------+----------------+-------------------------------------------------+
+| 2-4    |    2-4         | Reserved (must be 0).                           |
++--------+----------------+-------------------------------------------------+
+| 5      |     5          | Dynamic address translation 1=DAT on.           |
++--------+----------------+-------------------------------------------------+
+| 6      |     6          | Input/Output interrupt Mask                     |
++--------+----------------+-------------------------------------------------+
+| 7      |     7          | External interrupt Mask used primarily for      |
+|        |                | interprocessor signalling and clock interrupts. |
++--------+----------------+-------------------------------------------------+
+| 8-11   |   8-11         | PSW Key used for complex memory protection      |
+|        |                | mechanism (not used under linux)                |
++--------+----------------+-------------------------------------------------+
+| 12     |     12         | 1 on s/390 0 on z/Architecture                  |
++--------+----------------+-------------------------------------------------+
+| 13     |     13         | Machine Check Mask 1=enable machine check       |
+|        |                | interrupts                                      |
++--------+----------------+-------------------------------------------------+
+| 14     |     14         | Wait State. Set this to 1 to stop the processor |
+|        |                | except for interrupts and give  time to other   |
+|        |                | LPARS. Used in CPU idle in the kernel to        |
+|        |                | increase overall usage of processor resources.  |
++--------+----------------+-------------------------------------------------+
+| 15     |     15         | Problem state (if set to 1 certain instructions |
+|        |                | are disabled). All linux user programs run with |
+|        |                | this bit 1 (useful info for debugging under VM).|
++--------+----------------+-------------------------------------------------+
+| 16-17  |    16-17       | Address Space Control                           |
+|        |                |                                                 |
+|        |                | 00 Primary Space Mode:                          |
+|        |                |                                                 |
+|        |                | The register CR1 contains the primary           |
+|        |                | address-space control element (PASCE), which    |
+|        |                | points to the primary space region/segment      |
+|        |                | table origin.                                   |
+|        |                |                                                 |
+|        |                | 01 Access register mode                         |
+|        |                |                                                 |
+|        |                | 10 Secondary Space Mode:                        |
+|        |                |                                                 |
+|        |                | The register CR7 contains the secondary         |
+|        |                | address-space control element (SASCE), which    |
+|        |                | points to the secondary space region or         |
+|        |                | segment table origin.                           |
+|        |                |                                                 |
+|        |                | 11 Home Space Mode:                             |
+|        |                |                                                 |
+|        |                | The register CR13 contains the home space       |
+|        |                | address-space control element (HASCE), which    |
+|        |                | points to the home space region/segment         |
+|        |                | table origin.                                   |
+|        |                |                                                 |
+|        |                | See "Address Spaces on Linux for s/390 &        |
+|        |                | z/Architecture" below for more information      |
+|        |                | about address space usage in Linux.             |
++--------+----------------+-------------------------------------------------+
+| 18-19  |    18-19       | Condition codes (CC)                            |
++--------+----------------+-------------------------------------------------+
+| 20     |    20          | Fixed point overflow mask if 1=FPU exceptions   |
+|        |                | for this event occur (normally 0)               |
++--------+----------------+-------------------------------------------------+
+| 21     |    21          | Decimal overflow mask if 1=FPU exceptions for   |
+|        |                | this event occur (normally 0)                   |
++--------+----------------+-------------------------------------------------+
+| 22     |    22          | Exponent underflow mask if 1=FPU exceptions     |
+|        |                | for this event occur (normally 0)               |
++--------+----------------+-------------------------------------------------+
+| 23     |    23          | Significance Mask if 1=FPU exceptions for this  |
+|        |                | event occur (normally 0)                        |
++--------+----------------+-------------------------------------------------+
+| 24-31  |    24-30       | Reserved Must be 0.                             |
+|        +----------------+-------------------------------------------------+
+|        |    31          | Extended Addressing Mode                        |
+|        +----------------+-------------------------------------------------+
+|        |    32          | Basic Addressing Mode                           |
+|        |                |                                                 |
+|        |                | Used to set addressing mode                     |
+|        |                |                                                 |
+|        |                |    +---------+----------+----------+            |
+|        |                |    | PSW 31  | PSW 32   |          |            |
+|        |                |    +---------+----------+----------+            |
+|        |                |    |   0     |    0     |  24 bit  |            |
+|        |                |    +---------+----------+----------+            |
+|        |                |    |   0     |    1     |  31 bit  |            |
+|        |                |    +---------+----------+----------+            |
+|        |                |    |   1     |    1     |  64 bit  |            |
+|        |                |    +---------+----------+----------+            |
++--------+----------------+-------------------------------------------------+
+| 32     |                | 1=31 bit addressing mode 0=24 bit addressing    |
+|        |                | mode (for backward compatibility), linux        |
+|        |                | always runs with this bit set to 1              |
++--------+----------------+-------------------------------------------------+
+| 33-64  |                | Instruction address.                            |
+|        +----------------+-------------------------------------------------+
+|        |    33-63       | Reserved must be 0                              |
+|        +----------------+-------------------------------------------------+
+|        |    64-127      | Address                                         |
+|        |                |                                                 |
+|        |                |   - In 24 bits mode bits 64-103=0 bits 104-127  |
+|        |                |     Address                                     |
+|        |                |   - In 31 bits mode bits 64-96=0 bits 97-127    |
+|        |                |     Address                                     |
+|        |                |                                                 |
+|        |                | Note:                                           |
+|        |                |     unlike 31 bit mode on s/390 bit 96 must be  |
+|        |                |     zero when loading the address with LPSWE    |
+|        |                |     otherwise a specification exception occurs, |
+|        |                |     LPSW is fully backward compatible.          |
++--------+----------------+-------------------------------------------------+
 
 Prefix Page(s)
 --------------
-- 
2.21.0

