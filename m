Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 208AEDBD2D
	for <lists+linux-s390@lfdr.de>; Fri, 18 Oct 2019 07:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395269AbfJRFos (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 18 Oct 2019 01:44:48 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44138 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390035AbfJRFos (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 18 Oct 2019 01:44:48 -0400
Received: by mail-il1-f193.google.com with SMTP id f13so4403766ils.11
        for <linux-s390@vger.kernel.org>; Thu, 17 Oct 2019 22:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ofLqnhuaTacSfKe2YQoATYL+HC8rQjiCUNcY3XPivmE=;
        b=N5x8bC5o7w6rADZFh4KHeDpeb6o3Jgm+KphbQhVkPqZz1Fd8E9M3PaWuoBNyLGjNby
         FcCFIu+ox9T9DjhSC9heNZjMQrgm4xMjJ8TFBQCdlE86wvAdlBsUPOrsnGVYu9lKKeHQ
         D7w1xDFzmUYo0NdnoKDfVHfBV9rDMkKr3XHd+n6zCsh3R453pBKlec2RqfraXt+7FOJg
         3/bKBkC2vF8FVFJOQ2O0M59pBjRLRRSRz4XeMXB7o18TKzN8hqr5whm5Tas+OI+iIky7
         4MLLxBvYd+AUGMn4Rl6c+9BDiHaJCgsFf4PgCwD87izM7iHj9N5OArKOuTr8d8G+a9R5
         mQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ofLqnhuaTacSfKe2YQoATYL+HC8rQjiCUNcY3XPivmE=;
        b=l0JudT5jLUymn40nGRuwp2++ooKTfBqZvtPg3RBz2COOGKtrBahebGwsgb6tm5Y/PL
         FkeyEm/tREDnrutEEZJnBc6kTyLHC74/jX8xmUsujqh1fzarllXIwF2E8j3LrDhVbwgZ
         35O36XzglpxiQQskqLd7/KP9eYe7fjfmN1CsGOQMCQBJvDiakRYWktjfwcu1OVB2akFC
         dL7TFObMCnDbMl6BkMeWYNYuVXftETSsw+MrfOuiHqbDakmx1qMeR+8cKoi0N1m88Jnf
         in8XhXuTqqb+DOHyIwkvNW4bNo2ZQP1I/vIA2sSk49+Tcg3TH50L6a1U6djYAzSyyVlH
         FxmQ==
X-Gm-Message-State: APjAAAXsn22gQeXc+Trn9ITdKBZSkoGRy5HY7KjM5zoW/SCqg8MZVxzp
        sn6MEEdxLxwhiHxauhj/2weyVRr10PA=
X-Google-Smtp-Source: APXvYqykkUrK0vrBdmDDbwAwwr+5ZePp14K9XbkSbU4CaVjxo7HzjYRIh3HQWncCN26aSDHosD7Fnw==
X-Received: by 2002:a92:9a54:: with SMTP id t81mr8275762ili.197.1571370138242;
        Thu, 17 Oct 2019 20:42:18 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id d6sm1356657iop.34.2019.10.17.20.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 20:42:16 -0700 (PDT)
Date:   Thu, 17 Oct 2019 20:42:14 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, linux-mtd@lists.infradead.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, linux-riscv@lists.infradead.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 18/21] riscv: use the generic ioremap code
In-Reply-To: <20191017174554.29840-19-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1910172038040.3156@viisi.sifive.com>
References: <20191017174554.29840-1-hch@lst.de> <20191017174554.29840-19-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 17 Oct 2019, Christoph Hellwig wrote:

> Use the generic ioremap code instead of providing a local version.
> Note that this relies on the asm-generic no-op definition of
> pgprot_noncached.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

According to the series introduction E-mail:

https://lore.kernel.org/linux-riscv/20191017174554.29840-1-hch@lst.de/T/#m9ac4010fd725c8c84179fa99aa391a6f701a32de

nothing substantive related to RISC-V or the common code has changed since 
the first version of this series, and this RISC-V-specific patch appears 
to be quite close (if not identical) to the first version of the patch:

https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1908171421560.4130@viisi.sifive.com/

Thus the Tested-by, Reviewed-by, and Acked-by for RISC-V should all still 
apply:

https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1908171421560.4130@viisi.sifive.com/


- Paul
