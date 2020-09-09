Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A20D263023
	for <lists+linux-s390@lfdr.de>; Wed,  9 Sep 2020 17:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgIIPEF (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 9 Sep 2020 11:04:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729860AbgIIMSm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Sep 2020 08:18:42 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089B2lLN092037;
        Wed, 9 Sep 2020 07:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=sCHf8+v1z0J9ln9975zsHf4Oi+ryxNbRmCK/IUzVPlo=;
 b=n0WYgDx4uS2LNO7C+UIA2TZ22DbWM1GT9lLU8O+eGJ8EkiyNNal6g/0ThLsc/C6Rmzfe
 lpgpyDs5PNaThrXdsyVpAm07LWFOOJ62tOp0GvkOg+zng8xQcVRHLOREBohB3ON4UHe8
 GBfS82XxbRWbJ/LSmkLeWlQLMPucHolgawl2glM4CU+v/C82dRTbQqek2bVf+xHHDNu4
 zXm7fgSNIjYOOonwco9THzE2MlHGB8mcmrL82poROQ01AFon74J7fKmcRBRlv0jUBSLj
 Fd8zfv3DF6qXZYHkfBzceUAEgcW/fKsVWu4MgKMfdd4N7TSoNB3hqFKG+iFK/UHma7f1 5w== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33ewhcgtxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 07:10:08 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089B8GXS032086;
        Wed, 9 Sep 2020 11:10:06 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 33cm5hj7b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 11:10:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089BA3eJ64881038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 11:10:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7C8EAE055;
        Wed,  9 Sep 2020 11:10:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33122AE053;
        Wed,  9 Sep 2020 11:10:03 +0000 (GMT)
Received: from thinkpad (unknown [9.171.79.102])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  9 Sep 2020 11:10:03 +0000 (GMT)
Date:   Wed, 9 Sep 2020 13:10:01 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: Re: [PATCH v4 00/13] mm/debug_vm_pgtable fixes
Message-ID: <20200909131001.7b733b3e@thinkpad>
In-Reply-To: <ac85fd77-bca1-3318-de0e-eea40558cbbd@arm.com>
References: <20200902114222.181353-1-aneesh.kumar@linux.ibm.com>
        <bb0f3427-e2bd-f713-3ea8-d264be0e690b@arm.com>
        <20200904172647.002113d3@thinkpad>
        <20200904180115.07ee5f00@thinkpad>
        <ac85fd77-bca1-3318-de0e-eea40558cbbd@arm.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_06:2020-09-08,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 mlxlogscore=627 bulkscore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090095
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 9 Sep 2020 13:45:48 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

[...]
> > 
> > That would more match the "pte_t pointer" usage for hugetlb code,
> > i.e. just cast a pmd_t pointer to it. Also changed to pmd_aligned,
> > but I think the root cause is the pte_t pointer.
> 
> Ideally, the pte_t pointer used here should be from huge_pte_alloc()
> not from pte_alloc_map_lock() as the case currently.

Ah, good point. I assumed that this would also always return casted
pmd etc. pointers, and never pte pointers. Unfortunately, that doesn't
seem to be true for all architectures, e.g. ia64, parisc, (some) powerpc,
where they really do a pte_alloc_map() for some reason.

I guess that means you cannot simply cast the pmd pointer, as suggested,
although I really do not understand how any architecture can work with
real ptes for hugepages. But that's fair, s390 also does some things that
nobody would expect or understand for other architectures...

So, for using huge_pte_alloc() you'd also need some size, maybe
iterating over hstates with for_each_hstate() could be an option,
if they are already initialized at that point. Then you have the
size(s) with huge_page_size(hstate) and can actually call the
hugetlb tests for all supported sizes, and with proper pointer
from huge_pte_alloc().
