Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AD01BCDD8
	for <lists+linux-s390@lfdr.de>; Tue, 28 Apr 2020 22:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgD1U6n (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 28 Apr 2020 16:58:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50778 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgD1U6i (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 28 Apr 2020 16:58:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SKqvaJ036359;
        Tue, 28 Apr 2020 20:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=3EBd0JFCCDiBFwAIUR2awq/QssydoJhBBr3apN0hNL4=;
 b=nzmQliv6J5k3gHWPvWJnPS0vCXA935IwAWlquOi+UB4cAOG5GVA8x0EevBJ6Y7/4S/Wk
 cv/nnjbngxq/xJG7dp3yAjkB+bsgpWoDW9qZNV+cAqAZns+fDRhkr+rg2+tDHEZ/681c
 xkLQsXTstu9RMA24ANZwGtc5hQztAHf/yefkq+EIN6UcQxslL2wUYZ6Tq5F8xiUINzSg
 WRLXyPu9XyyVs0d1h1qHTOO5xQEIKOY9IVd4tzdbzR0qekcaam1PlrOpTOfy61AeKw2P
 r2lDbxIbSa7ZBs2XqvAuCMXzfVZKlVpJeAzcr+bTdwGyAVkjeLBKw+Kw/mVMVWpq+i94 sQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30nucg2bth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 20:56:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SKr0DT002838;
        Tue, 28 Apr 2020 20:56:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30my0ebuum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 20:56:31 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03SKuJJT014969;
        Tue, 28 Apr 2020 20:56:20 GMT
Received: from monkey.oracle.com (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 13:56:19 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Longpeng <longpeng2@huawei.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 0/4] Clean up hugetlb boot command line processing
Date:   Tue, 28 Apr 2020 13:56:10 -0700
Message-Id: <20200428205614.246260-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280163
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

v4 -
   Fixed huge page order definitions for arm64 (Qian Cai)
   Removed hugepages_supported() checks in command line processing as
     powerpc does not set hugepages_supported until later in boot (Sandipan)
   Added Acks, Reviews and Tested (Will, Gerald, Anders, Sandipan)

v3 -
   Used weak attribute method of defining arch_hugetlb_valid_size.
     This eliminates changes to arch specific hugetlb.h files (Peter)
   Updated documentation (Peter, Randy)
   Fixed handling of implicitly specified gigantic page preallocation
     in existing code and removed documentation of such.  There is now
     no difference between handling of gigantic and non-gigantic pages.
     (Peter, Nitesh).
     This requires the most review as there is a small change to
     undocumented behavior.  See patch 4 commit message for details.
   Added Acks and Reviews (Mina, Peter)

v2 -
   Fix build errors with patch 1 (Will)
   Change arch_hugetlb_valid_size arg to unsigned long and remove
     irrelevant 'extern' keyword (Christophe)
   Documentation and other misc changes (Randy, Christophe, Mina)
   Do not process command line options if !hugepages_supported()
     (Dave, but it sounds like we may want to additional changes to
      hugepages_supported() for x86?  If that is needed I would prefer
      a separate patch.)

Longpeng(Mike) reported a weird message from hugetlb command line processing
and proposed a solution [1].  While the proposed patch does address the
specific issue, there are other related issues in command line processing.
As hugetlbfs evolved, updates to command line processing have been made to
meet immediate needs and not necessarily in a coordinated manner.  The result
is that some processing is done in arch specific code, some is done in arch
independent code and coordination is problematic.  Semantics can vary between
architectures.

The patch series does the following:
- Define arch specific arch_hugetlb_valid_size routine used to validate
  passed huge page sizes.
- Move hugepagesz= command line parsing out of arch specific code and into
  an arch independent routine.
- Clean up command line processing to follow desired semantics and
  document those semantics.

[1] https://lore.kernel.org/linux-mm/20200305033014.1152-1-longpeng2@huawei.com

Mike Kravetz (4):
  hugetlbfs: add arch_hugetlb_valid_size
  hugetlbfs: move hugepagesz= parsing to arch independent code
  hugetlbfs: remove hugetlb_add_hstate() warning for existing hstate
  hugetlbfs: clean up command line processing

 .../admin-guide/kernel-parameters.txt         |  40 ++--
 Documentation/admin-guide/mm/hugetlbpage.rst  |  35 ++++
 arch/arm64/mm/hugetlbpage.c                   |  30 +--
 arch/powerpc/mm/hugetlbpage.c                 |  30 +--
 arch/riscv/mm/hugetlbpage.c                   |  24 +--
 arch/s390/mm/hugetlbpage.c                    |  24 +--
 arch/sparc/mm/init_64.c                       |  43 +----
 arch/x86/mm/hugetlbpage.c                     |  23 +--
 include/linux/hugetlb.h                       |   2 +-
 mm/hugetlb.c                                  | 180 ++++++++++++++----
 10 files changed, 260 insertions(+), 171 deletions(-)

-- 
2.25.4

