Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AE67E3F94
	for <lists+linux-s390@lfdr.de>; Tue,  7 Nov 2023 14:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjKGNGP (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 7 Nov 2023 08:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbjKGNGB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Nov 2023 08:06:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEBAD7C;
        Tue,  7 Nov 2023 04:54:08 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7BeuWg020167;
        Tue, 7 Nov 2023 12:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=cZ2UJAdL7WVvX4Zc+VxFFznJzLRVM+D12j8QJWWA3c0=;
 b=UdOzZzWLLXXIGYgf9OY0Y21YEYd/TMJHF6ZgP+/wQhaBzvALK1mRDNnqsYkHfpSzYsMA
 jZ5NvqAbFaPx3yP36yr7hCgE5ENMDX/zx209+/ojeXJfO0SQwKdn4ol/iiy1e8NldBl5
 Ili+9+bpuFeBcB0JVSMYjTw53X5AyGYenV6Dwi6yGS0vJkrckQ2YaeK26UWd9lbyYitv
 nFbpKc/gMp6kh3t71Y3jAW0ljbdK3+XH1muaL2f/8venYh68/Uq6aQb/frrUWMURrZPX
 myDxOSzMGZ/MGwt5IHv8HXa51+erHdLIXWi2GOEL2mzs1KGV+dN+fL1SgYKbWVJ2xyuZ fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7mck2euv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 12:54:07 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A7CBnbr020077;
        Tue, 7 Nov 2023 12:54:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7mck2eub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 12:54:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7CdFlt007974;
        Tue, 7 Nov 2023 12:54:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u60nygrxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 12:54:05 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A7Cs2i26619730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Nov 2023 12:54:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76B062004B;
        Tue,  7 Nov 2023 12:54:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D60420043;
        Tue,  7 Nov 2023 12:54:02 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Nov 2023 12:54:02 +0000 (GMT)
Date:   Tue, 7 Nov 2023 13:54:01 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     frankja@linux.ibm.com, thuth@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH v2 3/3] s390x: mvpg-sie: fix
 virtual-physical address confusion
Message-ID: <20231107135401.5d980831@p-imbrenda>
In-Reply-To: <20231106170849.1184162-4-nrb@linux.ibm.com>
References: <20231106170849.1184162-1-nrb@linux.ibm.com>
        <20231106170849.1184162-4-nrb@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nm2AoFKNn70bSU0RuEUhjXx8tUYeDgMn
X-Proofpoint-ORIG-GUID: HrPnyz2SKY4K5wGIDb38zPzQiRJVjyue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_04,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon,  6 Nov 2023 18:08:02 +0100
Nico Boehr <nrb@linux.ibm.com> wrote:

> The addresses reported for the partial execution of mvpg instruction are
> physical addresses. Now that MSO is a virtual address, we can't simply
> compare the PEI fields in the sie block with MSO, but need to do an
> additional translation step.
> 
> Add the necessary virtual-physical translations and expose the
> virt_to_pte_phys() function in mmu.h which is useful for this kind of
> translation.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>  lib/s390x/mmu.h  |  2 ++
>  s390x/mvpg-sie.c | 15 +++++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/s390x/mmu.h b/lib/s390x/mmu.h
> index dadc2e600f9a..e9e837236603 100644
> --- a/lib/s390x/mmu.h
> +++ b/lib/s390x/mmu.h
> @@ -95,4 +95,6 @@ static inline void unprotect_page(void *vaddr, unsigned long prot)
>  
>  void *get_dat_entry(pgd_t *pgtable, void *vaddr, enum pgt_level level);
>  
> +phys_addr_t virt_to_pte_phys(pgd_t *pgtable, void *vaddr);

or just #include <vmalloc.h> ?

[...]
