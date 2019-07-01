Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6390731B31
	for <lists+linux-s390@lfdr.de>; Sat,  1 Jun 2019 12:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfFAKVe (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 1 Jun 2019 06:21:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726109AbfFAKVe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 1 Jun 2019 06:21:34 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x51AHELe100019
        for <linux-s390@vger.kernel.org>; Sat, 1 Jun 2019 06:21:32 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sunds38c7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 01 Jun 2019 06:21:32 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 1 Jun 2019 11:21:30 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 1 Jun 2019 11:21:28 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x51ALRpj20447400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 1 Jun 2019 10:21:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42F1B4C046;
        Sat,  1 Jun 2019 10:21:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 217164C044;
        Sat,  1 Jun 2019 10:21:27 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  1 Jun 2019 10:21:27 +0000 (GMT)
Date:   Sat, 1 Jun 2019 12:21:25 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] s390: do not pass $(LINUXINCLUDE) to
 gen_opcode_table.c
References: <20190517075428.13496-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517075428.13496-1-yamada.masahiro@socionext.com>
X-TM-AS-GCONF: 00
x-cbid: 19060110-0012-0000-0000-00000321815E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060110-0013-0000-0000-0000215A561E
Message-Id: <20190601102125.GB3600@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906010076
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, May 17, 2019 at 04:54:24PM +0900, Masahiro Yamada wrote:
> I guess HOSTCFLAGS_gen_opcode_table.o was blindly copied from
> HOSTCFLAGS_gen_facilities.o
> 
> The reason of adding $(LINUXINCLUDE) to HOSTCFLAGS_gen_facilities.o
> is because gen_facilities.c references some CONFIG options. (Kbuild
> does not cater to this for host tools automatically.)
> 
> On the other hand, gen_opcode_table.c does not reference CONFIG
> options at all. So, there is no good reason to pass $(LINUXINCLUDE).
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/s390/tools/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
> index 2342b84b3386..4ff6a2124522 100644
> --- a/arch/s390/tools/Makefile
> +++ b/arch/s390/tools/Makefile
> @@ -15,7 +15,7 @@ hostprogs-y		    += gen_facilities
>  hostprogs-y		    += gen_opcode_table
> 
>  HOSTCFLAGS_gen_facilities.o += -Wall $(LINUXINCLUDE)
> -HOSTCFLAGS_gen_opcode_table.o += -Wall $(LINUXINCLUDE)
> +HOSTCFLAGS_gen_opcode_table.o += -Wall
> 
>  # Ensure output directory exists
>  _dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')

Applied, thanks.

