Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05A82FEAB7
	for <lists+linux-s390@lfdr.de>; Thu, 21 Jan 2021 13:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbhAUMxm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 21 Jan 2021 07:53:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731501AbhAUMuB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 07:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611233315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUEHrjYbNOrw/VnxdBA13Wmsgxi7HMEPIy1LTJm5oNs=;
        b=CjKSuhe6bFEAFuTx49yFV3Fmt6QE1nI0qshfPxt9Cp+3ngkxrhWHJ6lQAgORC/3jJGDjuM
        Rp+zRyU7s66pDaqy6dYDJ3/Zjw7iub+surwrtH+uafZ0pi1gTgeVL8VV2yQINRllc34yBs
        PgMDeMd2qblKBan3/Lx0z9iDpKPSDkA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-P2ycFeVNM4ezGqrit7Exrg-1; Thu, 21 Jan 2021 07:48:33 -0500
X-MC-Unique: P2ycFeVNM4ezGqrit7Exrg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E12E800D55;
        Thu, 21 Jan 2021 12:48:32 +0000 (UTC)
Received: from gondolin (ovpn-113-94.ams2.redhat.com [10.36.113.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64C921002382;
        Thu, 21 Jan 2021 12:48:27 +0000 (UTC)
Date:   Thu, 21 Jan 2021 13:48:24 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com,
        imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com
Subject: Re: [kvm-unit-tests PATCH v4 3/3] s390x: css: pv: css test
 adaptation for PV
Message-ID: <20210121134824.041100f3.cohuck@redhat.com>
In-Reply-To: <1611220392-22628-4-git-send-email-pmorel@linux.ibm.com>
References: <1611220392-22628-1-git-send-email-pmorel@linux.ibm.com>
        <1611220392-22628-4-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 21 Jan 2021 10:13:12 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> We want the tests to automatically work with or without protected
> virtualisation.
> To do this we need to share the I/O memory with the host.
> 
> Let's replace all static allocations with dynamic allocations
> to clearly separate shared and private memory.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css.h     |  3 +--
>  lib/s390x/css_lib.c | 28 ++++++++--------------------
>  s390x/css.c         | 43 +++++++++++++++++++++++++++++++------------
>  3 files changed, 40 insertions(+), 34 deletions(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

